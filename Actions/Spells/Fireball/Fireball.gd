extends SpellAction

const Fireball = preload("res://Assets/spells/Fireball/FireballEffect.tscn")
const Explosion = preload("res://Assets/spells/Fireball/explosion.wav")


func do_apply_action(targets):
	.do_apply_action(targets)
	var origin = turn_order.current_turn as CharacterNode
	origin.animation_player.play("Special")
	origin.animation_player.queue("Attack")
	origin.animation_player.queue("Idle")
	for character in targets:
		var fireball = Fireball.instance()
		fireball.play("Flying")
		fireball.global_position = origin.global_position
		EffectPlayer.add_child(fireball)
		fireball.flip_h = character.global_position.x < origin.global_position.x
		var tween = GlobalTree.get_tree().create_tween()
		tween.tween_callback(fireball, "cast")
		tween.tween_property(fireball, "global_position", character.global_position + character.get_rect().size/2, 0.6)
		tween.tween_callback(fireball, "explode")
		origin.attack(character, 1, 0)
