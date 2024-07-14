extends Node2D

signal moco_vel(vel_change)
signal game_over

const MIN_VEL: int = 20
const MAX_VEL: int = 30
const MOCO_VEL: float = 150
const MIN_VEL_CHANGE: float = 0.5
const MAX_VEL_CHANGE: float = 1.0

var actual_size_izq: float
var pos_izq: Vector2
var vel_izq: float

var actual_size_der: float
var pos_der: Vector2
var vel_der: float

var real_size: float
var game: bool = true
var processs = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$izq.position = get_window().size + Vector2i(-50, 55)
	$der.position = get_window().size + Vector2i(30, 55)
	real_size = 50
	actual_size_izq = 50
	actual_size_der = 50
	pos_izq = $izq.position
	pos_der = $der.position
	$pilot/AnimationPlayer.play("pilot")
	limpiar_moco()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if (Input.is_action_just_pressed("limpiar_moco_izq") or \
			Input.is_action_just_pressed("limpiar_moco_der")) and processs:
		$AudioStreamPlayer.play()
		var vel = sign(randf() - 0.5) * randf_range(MIN_VEL_CHANGE, MAX_VEL_CHANGE)
		moco_vel.emit(vel)
		#print("emitted ", vel)
	
	if (Input.is_action_pressed("limpiar_moco_izq") and \
			!Input.is_action_pressed("limpiar_moco_der")) and processs:
		actual_size_izq -= MOCO_VEL * delta
		actual_size_izq = max(actual_size_izq, real_size)
	else:
		actual_size_izq += vel_izq * delta
	
	if (Input.is_action_pressed("limpiar_moco_der") and \
			!Input.is_action_pressed("limpiar_moco_izq")) and processs:
		actual_size_der -= MOCO_VEL * delta
		actual_size_der = max(actual_size_der, real_size)
	else:
		actual_size_der += vel_der * delta
	
	$izq.scale.y = actual_size_izq / real_size
	$izq.position = pos_izq
	$der.scale.y = actual_size_der / real_size
	$der.position = pos_der

	if Input.is_action_just_released("limpiar_moco_izq") or \
			Input.is_action_just_released("limpiar_moco_der"):
		moco_vel.emit(0)
		#print("emitted 0")
		limpiar_moco()
	
	if ($izq.position.y + actual_size_izq > 1100 or \
			$der.position.y + actual_size_der > 1100) and game:
		game_over.emit()
		game = false
		#print("game over")
		
func limpiar_moco():
	vel_izq = randi_range(MIN_VEL, MAX_VEL)
	vel_der = randi_range(MIN_VEL, MAX_VEL)
	#print(vel_izq, " ", vel_der)
