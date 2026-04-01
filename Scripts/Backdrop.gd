extends ColorRect

func _ready() -> void:
	Global.theme_changed.connect(_on_theme_changed)
	_on_theme_changed()

func _on_theme_changed() -> void:
	color = Global.theme_config.backdrop_color
