extends Area2D
class_name Target

@export var vis : VisibleOnScreenNotifier2D
@export var icon : Sprite2D
@export var animation : AnimatedSprite2D
@export var collision : CollisionShape2D

func _ready():
	animation.hide()
	animation.frame = 0

func is_on_screen() -> bool:
	return vis.is_on_screen()

func die():
	collision.disabled = true
	animation.show()
	animation.play()

func _on_animated_sprite_2d_frame_changed():
	if animation.frame == 1:
		icon.hide()

func _on_animated_sprite_2d_animation_finished():
	call_deferred("queue_free")
