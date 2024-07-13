extends Node2D

var rotation_speed = 0.0
var max_rotation = 0.5
var min_speed = -4.0
var max_speed = 4.0
var rotation_aceleration = 0.2
var return_speed = 20

signal speed_changed(new_speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(rotation)
	print(rotation_speed)
	if Input.is_action_pressed("ui_right"):
		rotation_speed += rotation_aceleration * delta
		emit_signal("speed_changed", rotation_speed)
	elif Input.is_action_pressed("ui_left"):
		rotation_speed -= rotation_aceleration * delta
		emit_signal("speed_changed", rotation_speed)
	else:
		if abs(rotation) > 0.001:
			var dir = sign(rotation)
			rotation_speed = -dir * return_speed * delta
		else:
			rotation = 0
			rotation_speed = 0
			
	rotation_speed = clamp(rotation_speed, -max_speed, max_speed)
	rotation += rotation_speed * delta
	rotation = clamp(rotation, -max_rotation, max_rotation)
