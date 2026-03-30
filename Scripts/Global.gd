extends Node

# Request an animation from any AnimationBuses.
@warning_ignore("unused_signal")
signal request_animation(anim_name:String)

## -- INPUT -- ##

# Emitted when a key is pressed / released.
signal key_pressed(key_name:String, echo:bool, power:bool)
signal key_released(key_name:String, echo:bool, power:bool)

## Keys to be parsed seperately from the other keys.
var power_keys := [
	&"Escape",
	&"QuoteLeft",
	&"Tab",
	&"Shift",
	&"CapsLock",
	&"Ctrl",
	&"Option",
	&"Command",
	&"Backspace",
	&"Enter",
	&"Shift",
	&"Space"
]

## Keys whose name aren't just their response from the function.
var special_keys := {
	"BackSlash": "\\",
	"Equal": "=",
	"Minus": "-",
	"BracketLeft": "[",
	"BracketRight": "]",
	"Semicolon": ";",
	"Apostrophe": "'",
	"Slash": "/",
	"Period": ".",
	"Comma": ","
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed(): # Bus all key presses into key_pressed and key_released.
		var key = OS.get_keycode_string(event.keycode)
		
		#var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		#var label = DisplayServer.keyboard_get_label_from_physical(event.physical_keycode)
		
		var emission := key_pressed if event.is_pressed() else key_released
		
		if special_keys.has(key): key = special_keys[key]
		
		emission.emit(key, event.echo, power_keys.has(key))
