extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var controls = $Controls
	controls.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_up():
	get_tree().change_scene_to_file("res://moco/moco.tscn")


func _on_controles_pressed():
	
	var controls = $Controls
	controls.visible = true


func _on_close_button_up():
	#Close controls menu
	var controls = $Controls
	controls.visible = false
