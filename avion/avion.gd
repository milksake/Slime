extends Node2D

var rotation_speed = 0.0
var max_rotation = 0.5
var min_speed = -0.6
var max_speed = 0.6
var rotation_aceleration = 0.2
var return_speed = 0.01

@export var planeSprite : Sprite2D

var processs = true

signal speed_changed(new_speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right") and processs:
		rotation_speed += rotation_aceleration * delta
		#print(rotation_speed)
	elif Input.is_action_pressed("ui_left") and processs:
		rotation_speed -= rotation_aceleration * delta
		#print(rotation_speed)
	else:
		if rotation_speed < 0:
			rotation_speed += return_speed
			if rotation_speed > 0:
				rotation_speed = 0
		elif rotation_speed > 0:
			rotation_speed -= return_speed
			if rotation_speed < 0:
				rotation_speed = 0

	rotation_speed = clamp(rotation_speed, -max_speed, max_speed)
	if rotation_speed != planeSprite.rotation:
		emit_signal("speed_changed", rotation_speed*2)
		
	planeSprite.rotation = rotation_speed
	#print(rotation_speed)
