extends Terminal

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
