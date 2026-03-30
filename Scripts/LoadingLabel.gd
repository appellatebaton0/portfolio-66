class_name LoadingLabel extends Label
## Allows for a little spinning loading character. Replaces % with it.

@onready var original_text := text

@export var speed = 1.0
var timer = 0.0
var index = 0
var chars = ["\\", "-", "/", "-"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timer = move_toward(timer, 1.0, delta * speed)
	
	if timer >= 1.0:
		index = wrap(index + 1, 0, len(chars))
		timer = 0.0
	
	text = original_text.replace("%", chars[index])
