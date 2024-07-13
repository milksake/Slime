extends Node2D

var currScene = 0

@export var binocular : Node2D
@export var avion : Node2D
@export var moco : Node2D

@onready var scenes : Array = [
	binocular,
	avion,
	moco
]

func _ready():
	avion.hide()
	moco.hide()

func _process(delta):
	if currScene != 0 and Input.is_action_just_pressed("change_to_binocular"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		currScene = 0
		scenes[currScene].show()
		scenes[currScene].processs = true
		binocular.enableCamera()
		
	elif currScene != 1 and Input.is_action_just_pressed("change_to_avion"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		currScene = 1
		scenes[currScene].show()
		scenes[currScene].processs = true
	elif currScene != 2 and Input.is_action_just_pressed("change_to_moco"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		currScene = 2
		scenes[currScene].show()
		scenes[currScene].processs = true
	if currScene != 0:
		binocular.disableCamera()

func _on_avion_speed_changed(new_speed):
	binocular.plane_angular_velocity = new_speed

func _on_moco_moco_vel(vel_change):
	binocular.moco_angular_velocity = vel_change

func _on_moco_game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
