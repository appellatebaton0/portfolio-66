class_name Character extends Resource
## The base class for all characters (enemies + the player)

## -- IDENTITY -- ## 

signal name_changed

## The name of this character.
@export var name:StringName:
	set(to):
		name = to
		name_changed.emit()

## -- HEALTH -- ##

signal was_hurt(amount:int)
signal was_heal(amount:int)

signal died

## The current health.
var health:int
## The maximum health
@export var max_health := 30

func reset_health() -> void: health = max_health
func heal(amount:int) -> void: 
	health = clamp(health + amount, 0, max_health)
	was_heal.emit(amount)
func hurt(amount:int) -> void: 
	health = clamp(health - amount, 0, max_health)
	was_hurt.emit(amount)
	
	if health <= 0: died.emit()

## -- LETTER MANAGEMENT -- ##

signal hand_changed
signal discard_changed
signal deck_changed

## The current hand of letters.
var hand:Array[Letter]: 
	set(to):
		hand = to
		hand_changed.emit()
## How many letters the hand can hold.
@export var hand_size := 1

## The available deck pile.
var deck:Array[Letter]:
	set(to):
		deck = to
		deck_changed.emit()
## The used discard pile.
var discard:Array[Letter]:
	set(to):
		discard = to
		discard_changed.emit()

## The character's actual set of letters. For reseting after each combat.
@export var reserve_deck:Array[Letter]

## Clear out all the current letters in the hand, and add in new ones.
func refresh_hand() -> void:
	for letter in hand:
		discard_letter(letter)
	
	for i in range(hand_size):
		hand.append(draw_letter())

## Draw a letter from the deck. This should usually only be called by the hand.
func draw_letter() -> Letter:
	if len(deck) == 0:
		deck = discard.duplicate()
		deck.shuffle()
	
	return deck.pop_front()

func discard_letter(letter:Letter):
	discard.append(letter)

## Add a letter into the deck.
func add_letter(letter:Letter) -> void:
	reserve_deck.append(letter)

## Reset the deck.
func reset_deck() -> void:
	deck = reserve_deck
	deck.shuffle()
	discard = []

## -- GENERIC -- ##

## Reset the character after combat.
func combat_reset() -> void:
	reset_deck()
	reset_health()
