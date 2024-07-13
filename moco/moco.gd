extends Polygon2D

signal moco_vel(vel_change)
signal game_over

const MIN_VEL: int = 20
const MAX_VEL: int = 30
const MOCO_VEL: int = 150
const MIN_VEL_CHANGE: float = 0.2
const MAX_VEL_CHANGE: float = 0.5
var pos: Vector2
var y_real_size: float
var y_actual_size: float
var yvel: int
var other: String
var game: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_window().size
	print(position)
	if name == "izq":
		other = "der"
		position.x -= 50
	else:
		other = "izq"
		position.x += 50
	
	y_real_size = 50
	pos = position
	yvel = randi_range(MIN_VEL, MAX_VEL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("limpiar_moco_"+name):
		var vel = sign(randf() - 0.5) * randf_range(MIN_VEL_CHANGE, MAX_VEL_CHANGE)
		moco_vel.emit(vel)
		print("emitted ", vel)
		
	if !Input.is_action_pressed("limpiar_moco_"+other) and \
			Input.is_action_pressed("limpiar_moco_"+name):
		y_actual_size -= MOCO_VEL * delta
		y_actual_size = max(y_actual_size, y_real_size)
	else:
		y_actual_size += yvel * delta
	
	scale.y = y_actual_size / y_real_size
	position = pos
	if Input.is_action_just_released("limpiar_moco_"+name):
		moco_vel.emit(0)
		print("emitted 0")
		limpiar_moco()
	
	if pos.y + y_actual_size > 1100 and game:
		game_over.emit()
		game = false
		print("game over")
		
func limpiar_moco():
	yvel = randi_range(MIN_VEL, MAX_VEL)
	# position.y = 0
