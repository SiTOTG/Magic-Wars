class_name SpellAction
extends Action

export var spell_animation: String = "Spell"
export (int) var manacost: int = 10

func is_available():
	var origin = turn_order.current_turn as CharacterNode
	return origin.check_mp(manacost)

func do_apply_action(targets):
	var origin = turn_order.current_turn as CharacterNode
	origin.mp -= manacost
	origin.animation_player.play("Special")
	origin.animation_player.queue("Attack")
	origin.animation_player.queue("Idle")
	for character in targets:
		origin.attack(character)
