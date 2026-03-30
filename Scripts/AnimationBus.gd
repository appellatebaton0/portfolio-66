class_name AnimationBus extends AnimationPlayer
## Manages all animations for the game.

func _ready() -> void:
	Global.request_animation.connect(_on_requested_animation)

func _on_requested_animation(anim_name:String) -> void:
	if not is_playing() and has_animation(anim_name):
		play(anim_name)
