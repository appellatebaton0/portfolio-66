class_name GameHandler extends Control
## Handles all the higher-level stuff for the game. I'm too tired to make it less
## clunky.

@export var focused := false

func _ready() -> void:
	Global.key_pressed.connect(_on_key_pressed)

func _on_key_pressed(key_name:String, _echo:bool, power:bool): if focused:
	
	if power and key_name == "Escape":
		Global.request_animation.emit("Pause")
	
	pass
