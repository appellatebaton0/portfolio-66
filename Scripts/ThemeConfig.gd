class_name ThemeConfig extends Resource
## Stores information about the colors for the game. Hot-swappable.

@export_group("Backdrop", "backdrop_")
@export var backdrop_color:Color
@export var backdrop_font_color:Color

@export var default_text_color:Color
@export var lesser_text_color:Color

@export_group("Health", "health_color_")
@export var health_color_low:Color
@export var health_color_med:Color
@export var health_color_hig:Color
