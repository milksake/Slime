extends CanvasLayer

@onready var conts : Array[MarginContainer] = [
	$Control/BinocularUI,
	$Control/PlaneUI,
	$Control/MocoUI,
]

@onready var danger = $Control/Danger
@onready var scoreLabel = $Control/Score/Label

func _ready():
	conts[1].hide()
	conts[2].hide()
	danger.hide()

func deactivateActivate(a, b):
	conts[a].hide()
	conts[b].show()

func activateDanger():
	danger.show()

func deactivateDanger():
	danger.hide()

func setTargets(num):
	scoreLabel.text = "Targets Destroyed: " + str(num)
