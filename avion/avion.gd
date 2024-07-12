extends Node2D
var rotation_speed = 0.5
var rotation_dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_window().size / 2
	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		rotation_dir = rotation_speed
	elif Input.is_action_pressed("ui_left"):
		rotation_dir = -rotation_speed
	else:
		if rotation > 0:
			rotation_dir = -rotation_speed/2
		elif rotation < 0:
			rotation_dir = rotation_speed/2
	rotation += rotation_dir * delta
