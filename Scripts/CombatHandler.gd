class_name CombatHandler extends Control
## Handles all the higher-level stuff for the combat screen. I'm too tired to make it less
## clunky.

@onready var player_hand_lab := %Hand

@onready var player_hp_lab := %HP
@onready var player_draw_lab := %Draw
@onready var player_discard_lab := %Discard

@onready var player_lab := %PlayerLabel

@export var focused := false

var player:Character
var enemy:Character = preload("res://Assets/Characters/Rat.tres")

func _ready() -> void:
	
	Global.key_pressed.connect(_on_key_pressed)
	
	## Update the player.
	player = Global.player
	player.combat_reset()
	_wire_player_signals()

## INPUT
func _on_key_pressed(key_name:String, _echo:bool, power:bool): if focused:
	
	## Handle Pausing.
	if power and key_name == "Escape":
		Global.request_animation.emit("Pause")

## -- PLAYER HANDLING -- ##

## Hook up and update the obscene amount of signals.
func _wire_player_signals() -> void:
	player.name_changed.connect(_on_player_name_changed)
	player.deck_changed.connect(_on_player_deck_changed)
	player.discard_changed.connect(_on_player_disc_changed)
	player.hand_changed.connect(_on_player_hand_changed)
	player.was_heal.connect(_on_player_heal_changed)
	player.was_hurt.connect(_on_player_heal_changed)
	update_player_display()

func update_player_display() -> void:
	_on_player_name_changed()
	_on_player_deck_changed()
	_on_player_disc_changed()
	_on_player_hand_changed()
	_on_player_heal_changed()

func _on_player_name_changed() -> void:
	player_lab.text = player.name
func _on_player_deck_changed() -> void:
	player_draw_lab.text = Global.as_digital_string(len(player.deck), 3)
func _on_player_disc_changed() -> void:
	player_discard_lab.text = Global.as_digital_string(len(player.discard), 3)
func _on_player_hand_changed() -> void:
	player_hand_lab.text = ""
	
	for letter in player.hand:
		player_hand_lab.text += letter.letter
	
func _on_player_heal_changed(_amnt:int = -1) -> void:
	player_hp_lab.text   = Global.as_digital_string(player.health, 3)
