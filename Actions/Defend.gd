class_name Defend
extends Action

func do_apply_action(targets: Array):
	for target in targets:
		target = target as CharacterNode
		target.is_defending = true
