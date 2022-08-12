extends SpellAction

func do_apply_action(targets):
	.do_apply_action(targets)
	var origin = turn_order.current_turn as CharacterNode
	origin.animation_player.play("Special")
	origin.animation_player.queue("Attack")
	origin.animation_player.queue("Idle")
	for character in targets:
		origin.attack(character)
	pass
