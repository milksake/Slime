extends Node2D

func _ready():
	$Label2.text = "Targets destroyed: " + str(Globals.numTargets)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
