class_name A extends Letter

func _get_letter() -> StringName:      return "A"
func _get_description() -> StringName: return "Does 1 damage to the opponent."

func used(_by:Character, on:Character) -> void: on.hurt(1)
