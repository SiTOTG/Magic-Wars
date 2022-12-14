class_name SpellAction
extends Action

export var spell_animation: String = "Spell"
export (int) var manacost: int = 10

func is_available():
	var origin = turn_order.current_turn as CharacterNode
	return origin.check_mp(manacost)

func do_apply_action(_targets):
	var origin = turn_order.current_turn as CharacterNode
	origin.mp -= manacost
	
