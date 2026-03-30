class_name Terminal extends VBoxContainer
## The menu terminal for the game.

@export var focused := true
var current_label:RichTextLabel
var current_real_text := ""

@export var visible_characters := -1

@export var blink_speed := 1.0
var timer := 0.0

var scroll:ScrollContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.key_pressed.connect(_on_key_pressed)
	on_enter()
	print(current_label)
	current_real_text = "PRESS ENTER"
	print(current_real_text)
	
	var parent = get_parent()
	if parent is ScrollContainer:
		scroll = parent

func _process(delta: float) -> void:
	current_label.text = current_real_text.replace(" ", "[color=#00000000]|[/color]")
	if timer > 0.5:
		current_label.text += "_"
	
	timer = move_toward(timer, 0.0, delta * blink_speed)
	if timer == 0:
		timer = 1.0
	
	if scroll:
		scroll.scroll_vertical += 100
	
	for child in get_children():
		if child is RichTextLabel:
			child.visible_characters = visible_characters

func _on_key_pressed(key_name:String, _echo:bool, power:bool): if focused:
	
	timer = 1.0
	
	if power:
		match key_name:
			"Space":
				print("ADD")
				current_real_text += " "
			"Enter":
				on_enter()
			"Backspace":
				current_real_text = current_real_text.left(len(current_real_text) - 1)
	else:
		current_real_text += key_name

func on_enter() -> void:
	
	if current_label:
		current_label.text = current_real_text.replace(" ", "[color=#00000000]|[/color]")
		
		if len(current_real_text) == 0:
			print("freed D:")
			current_label.queue_free()
		else:
			parse_command(current_real_text)
	
	current_label = RichTextLabel.new()
	current_label.bbcode_enabled = true
	current_label.fit_content = true
	
	current_label.custom_minimum_size.y = 17
	#current_label.use_parent_material = true
	
	current_real_text = ""
	
	add_child(current_label)

func parse_command(command:String):
	
	## Allow semicolon seperated commands, like clear;help to do both.
	if command.contains(";"):
		for subcommand in command.split(";"):
			parse_command(subcommand)
		return
	
	match command:
		"": return
		"CLEAR":
			for child in get_children(): child.queue_free()
		"START":
			Global.request_animation.emit("Start")
		"QUIT":
			get_tree().quit()
		"HELP":
			push_text("--")
			push_text("COMMANDS")
			push_text("")
			push_text("HELP - SHOW THIS LIST")
			push_text("")
			push_text("CLEAR - CLEAR THE TERMINAL")
			push_text("")
			push_text("START - START A RUN")
			push_text("")
			push_text("OPTIONS - VIEW OPTIONS")
			push_text("")
			push_text("QUIT - QUIT THE GAME")
			push_text("")
		_: ## Command not found.
			push_text("[color=%s]THAT COMMAND DOESN'T EXIST. TRY \"HELP\"" % [Color(1.0, 0.263, 0.166, 1.0).to_html()])

func push_text(string:String):
	var new = RichTextLabel.new()
	
	new.bbcode_enabled = true
	new.fit_content = true
	
	new.custom_minimum_size.y = 17
	#new.use_parent_material = true
	
	new.text = string
	new.text = new.text.replace(" ", "[color=#00000000]|[/color]")
	
	add_child(new)
