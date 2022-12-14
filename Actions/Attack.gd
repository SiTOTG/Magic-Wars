class_name Attack
extends Action

export var attack_animation: String = "Attack"
export (Array, String) var optional_chain = []
export (int) var flat_damage = 0
export (int) var damage_scale = 1

func do_apply_action(targets):
	var origin = turn_order.current_turn as CharacterNode
	if optional_chain:
		origin.animation_player.play(attack_animation)
		for additional_animation in optional_chain:
			origin.animation_player.queue(additional_animation)
		origin.animation_player.queue("Idle")
	else:
		origin.play_animation(attack_animation)
	for character in targets:
		origin.attack(character, flat_damage, damage_scale)
