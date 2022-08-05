class_name Self
extends Target

func get_targets() -> Array:
	return [turn_order.current_turn]
#	return GlobalTree.get_tree().get_nodes_in_group("Characters")
