class_name Attack
extends Action

func do_apply_action(targets):
	for character in targets:
		turn_order.current_turn.attack(character)
