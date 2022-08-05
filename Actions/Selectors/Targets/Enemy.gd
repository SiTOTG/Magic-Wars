class_name EnemyTarget
extends Target

func get_targets() -> Array:
	var current: CharacterNode = turn_order.current_turn
	var enemy_team = "P2 Characters"
	if "P2 Characters" in current.get_groups():
		enemy_team = "P1 Characters"
	var enemy_characters = GlobalTree.get_tree().get_nodes_in_group(enemy_team).duplicate()
	return enemy_characters
