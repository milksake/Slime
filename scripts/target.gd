extends Area2D
class_name Target

@export var vis : VisibleOnScreenNotifier2D

func is_on_screen() -> bool:
	return vis.is_on_screen()
