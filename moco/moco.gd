extends Polygon2D

signal moco_inhalation(vel_change)

@export var MIN_VEL: int
@export var MAX_VEL: int
@export var MOCO_VEL: int
@export var MIN_VEL_CHANGE: float
@export var MAX_VEL_CHANGE: float
var yvel = randi_range(MIN_VEL, MAX_VEL)
var other: String

# Called when the node enters the scene tree for the first time.
func _ready():
	if name == "izq":
		other = "der"
	else:
		other = "izq"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("limpiar_moco_"+name):	
		moco_inhalation.emit(sign(randf() - 0.5) * randf_range(MIN_VEL_CHANGE, MAX_VEL_CHANGE))
		
	if !Input.is_action_pressed("limpiar_moco_"+other) and \
			Input.is_action_pressed("limpiar_moco_"+name):
		position.y -= MOCO_VEL * delta
		position.y = max(position.y, 0)
	else:
		position.y += yvel * delta
	
	if Input.is_action_just_released("limpiar_moco_"+name):
		limpiar_moco()
		
func limpiar_moco():
	yvel = randi_range(MIN_VEL, MAX_VEL)
	# position.y = 0
