extends Node2D

@export var plane_velocity : float
@export var turn_velocity : float
@export var target_symbol_velocity : float

@export var target_scene : PackedScene
@export var arrow : Arrow
@export var camera : Camera2D
@export var target_symbol : Area2D

@export var spawnAreaLimits : Rect2

var target : Target

var tl : float
var tr : float
var dl : float
var dr : float

func _ready():
	newTarget()
	var cameraRect = camera.get_viewport_rect().size
	tl = fmod(Vector2(-cameraRect.x/2, -cameraRect.y/2).angle() + 4*PI, 2*PI)
	tr = fmod(Vector2(cameraRect.x/2, -cameraRect.y/2).angle() + 4*PI, 2*PI)
	dl = fmod(Vector2(-cameraRect.x/2, cameraRect.y/2).angle() + 4*PI, 2*PI)
	dr = fmod(Vector2(cameraRect.x/2, cameraRect.y/2).angle() + 4*PI, 2*PI)

func _process(delta):
	camera.position -= Vector2.from_angle(camera.rotation + PI/2) * plane_velocity * delta
	
	var disp = camera.to_local(target.global_position)
	var ang = fmod(disp.angle() + 4*PI, 2*PI)
	var length
	if (ang > dr and ang < dl) or (ang > tl and ang < tr):
		var y = camera.get_viewport_rect().size.y/2 * (1 if ang < PI else -1)
		length = disp.length() * y/disp.y
	else:
		var x = camera.get_viewport_rect().size.x/2 * (-1 if ang > PI/2 and ang < 3*PI/2 else 1)
		length = disp.length() * x/disp.x
	arrow.position = disp.normalized() * (length - 110)
	arrow.rotation = ang
	
	var mouse_pos = camera.get_local_mouse_position()
	if target_symbol.position != mouse_pos:
		target_symbol.position += target_symbol_velocity * (mouse_pos - target_symbol.position).normalized()
	if target_symbol.position.distance_to(mouse_pos) <= target_symbol_velocity:
			target_symbol.position = mouse_pos
	if Input.is_action_pressed("ui_left"):
		turn(-delta*turn_velocity)
	if Input.is_action_pressed("ui_right"):
		turn(delta*turn_velocity)
	arrow.visible = not target.is_on_screen()

func newTarget():
	target = target_scene.instantiate()
	target.connect("input_event", destroyTarget.bind(target))
	var cameraRect = camera.get_viewport_rect().size
	target.position.x = camera.position.x + (randf_range(spawnAreaLimits.position.x, -cameraRect.x/2 - 100) if randi_range(0, 1) else randf_range(cameraRect.x/2 + 100, spawnAreaLimits.position.x + spawnAreaLimits.size.x))
	target.position.y = camera.position.y + (randf_range(spawnAreaLimits.position.y, -cameraRect.y/2 - 100) if randi_range(0, 1) else randf_range(cameraRect.y/2 + 100, spawnAreaLimits.position.y + spawnAreaLimits.size.y))
	add_child(target)
	print("newTarget")

func destroyTarget(_v, event, _i, targett):
	if event.is_action_pressed("left_click") and target_symbol.has_overlapping_areas():
		targett.visible = false
		targett.call_deferred("queue_free")
		print("targetDestroyed")
		newTarget()

func turn(radians):
	camera.rotate(radians)
	#print("rotated")
