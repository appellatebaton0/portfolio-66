class_name NextRoomHandler extends Control

@onready var option_indicator := %OptionIndicators
var selected_index = -1:
	set(to):
		selected_index = to
		blink_timer = 1.0
		update_selection()

var blink_timer := 1.0

@export var focused := true


func _ready() -> void:
	Global.key_pressed.connect(_on_key_pressed)
	update_selection()

func _on_key_pressed(key_name:String, _echo:bool, _power:bool): if focused:
	
	match key_name:
		"1": selected_index = 0
		"2": selected_index = 1
		"3": selected_index = 2
		"Enter":
			attempt_selection()

func _process(delta: float) -> void:
	for child in option_indicator.get_children():
		child.modulate.a = 0.0 if blink_timer < 0.5 else 1.0
	
	blink_timer = move_toward(blink_timer, 0.0, delta / 1.2)
	if blink_timer == 0: blink_timer = 1.0

func update_selection() -> void:
	var children = option_indicator.get_children()
	for i in range(len(children)):
		children[i].visible = i == selected_index

func attempt_selection() -> void:
	pass
