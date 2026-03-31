extends Terminal

func _on_key_pressed(key_name:String, _echo:bool, power:bool): if focused:
	
	if power and key_name == "Escape":
		Global.request_animation.emit("Unpause")
	
	super._on_key_pressed(key_name, _echo, power)

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
			push_text("UNPAUSE - UNPAUSE THE GAME (ESC)")
			push_text("")
			push_text("QUIT - QUIT THE GAME")
			push_text("")
		"UNPAUSE":
			Global.request_animation.emit("Unpause")
		_: ## Command not found.
			push_text("[color=%s]THAT COMMAND DOESN'T EXIST. TRY \"HELP\"" % [Color(1.0, 0.263, 0.166, 1.0).to_html()])
