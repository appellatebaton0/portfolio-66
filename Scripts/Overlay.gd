extends Control
## The overlay for the entire game, everything but the black background.

## Camera-shake
var shake_amount:Vector2
var shake_time:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.request_camera_shake.connect(_on_shake_requested)
	Global.theme_changed.connect(_on_theme_changed)
	_on_theme_changed()

func _process(delta: float) -> void:
	
	if shake_time > 0.0:
		shake_time = move_toward(shake_time, 0, delta)
		
		position = get_shake()
	else:
		position = Vector2.ZERO
	
	## DEBUG, SO I CAN MAKE SCREENS INVISIBLE
	#for child in get_children(): if child is Control: child.show()

func _on_shake_requested(amount:Vector2, time:float):
	shake_amount = amount
	shake_time = time

func get_shake() -> Vector2:
	var x := randf_range(-shake_amount.x, shake_amount.x)
	var y := randf_range(-shake_amount.y, shake_amount.y)
	
	return Vector2(x,y)

func _on_theme_changed() -> void: theme_update(self)

func theme_update(from:Node):
	
	if from.has_meta("theme_type"):
		var type:StringName = from.get_meta("theme_type", &"default_text_color")
		
		if from is Label:
			from.add_theme_color_override("font_color", Global.theme_config.get(type))
		if from is RichTextLabel:
			from.add_theme_color_override("default_color", Global.theme_config.get(type))
	
	for child in from.get_children():
		theme_update(child)
