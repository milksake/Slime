extends Node2D

var currScene = 0

@export var binocular : Node2D
@export var avion : Node2D
@export var moco : Node2D

@export var ui : CanvasLayer

@onready var scenes : Array = [
	binocular,
	avion,
	moco
]

var targetsDestroyed = 0

func _ready():
	avion.hide()
	avion.processs = false
	moco.hide()
	moco.processs = false
	ui.setTargets(0)
	Globals.numTargets = 0

func _process(delta):
	if currScene != 0 and Input.is_action_just_pressed("change_to_binocular"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		ui.deactivateActivate(currScene, 0)
		currScene = 0
		scenes[currScene].show()
		scenes[currScene].processs = true
		binocular.enableCamera()
		
	elif currScene != 1 and Input.is_action_just_pressed("change_to_avion"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		ui.deactivateActivate(currScene, 1)
		currScene = 1
		scenes[currScene].show()
		scenes[currScene].processs = true
	elif currScene != 2 and Input.is_action_just_pressed("change_to_moco"):
		scenes[currScene].hide()
		scenes[currScene].processs = false
		ui.deactivateActivate(currScene, 2)
		currScene = 2
		scenes[currScene].show()
		scenes[currScene].processs = true
		ui.deactivateDanger()
	if currScene != 0:
		binocular.disableCamera()

func _on_avion_speed_changed(new_speed):
	binocular.plane_angular_velocity = new_speed

func _on_moco_moco_vel(vel_change):
	binocular.moco_angular_velocity = vel_change

func _on_moco_game_over():
	Globals.numTargets = targetsDestroyed
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_moco_danger():
	if currScene != 2:
		ui.activateDanger()

func _on_binocular_target_destroyed():
	targetsDestroyed += 1
	ui.setTargets(targetsDestroyed)
