extends Node2D

export (Array, Resource) var actions = []

func _ready():
	for action in actions:
		action.characters = get_tree().get_nodes_in_group("Characters")
		action.turn_order = $CanvasLayer/TurnOrder
		action.ui = $CanvasLayer

func _on_finished_action():
	$CanvasLayer/TurnOrder.go_to_next_turn()


func _on_Attack_pressed():
	for action in actions:
		if action is Attack:
			action.selector.start_selection()
			action.connect("finished_action", self, "_on_finished_action")
