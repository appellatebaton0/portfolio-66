@abstract class_name Letter extends Resource
## The abstract base class for all actions.

## A wrapper for _get_letter.
var letter:StringName: get = _get_letter

## The letter this shows up as. Should be a single character.
@abstract func _get_letter() -> StringName

## A wrapper for _get_description.
var description:StringName: get = _get_description

## The letter this shows up as. Should be a single character.
@abstract func _get_description() -> StringName

## What happens when this letter is used. Can affect the user or the target, and use anything from either.
@abstract func used(by:Character, on:Character) -> void
