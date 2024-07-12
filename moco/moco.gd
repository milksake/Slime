extends Polygon2D

const MIN_VEL = 10
const MAX_VEL = 40
const MOCO_VEL = 150
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
func _process(delta):
	if !Input.is_action_pressed("limpiar_moco_"+other) and Input.is_action_pressed("limpiar_moco_"+name):
		position.y -= MOCO_VEL * delta
		position.y = max(position.y, 0)
	else:
		position.y += yvel * delta
	
	if Input.is_action_just_released("limpiar_moco_"+name):
		limpiar_moco()
		
func limpiar_moco():
	yvel = randi_range(MIN_VEL, MAX_VEL)
	# position.y = 0
