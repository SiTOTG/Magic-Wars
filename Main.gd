extends Control

export (Array, Resource) var actions = []

onready var turn_order = $CanvasLayer/TurnOrder
onready var action_list = $CanvasLayer/MarginContainer/ActionList

func _ready():
	for action in actions:
		action.characters = get_tree().get_nodes_in_group("Characters")
		action.turn_order = turn_order
		action.ui = $CanvasLayer
		action.connect("finished_action", self, "_on_finished_action")
	
		action_list.add_action(action)
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode:
			character.connect("death", self, "_check_gameover_condition")

func _on_finished_action():
	turn_order.go_to_next_turn()
	if turn_order.current_turn:
		turn_order.current_turn.start_turn()

func _on_Attack_pressed():
	for action in actions:
		if action is Attack:
			action.selector.start_selection()
			action.connect("finished_action", self, "_on_finished_action")

func _check_gameover_condition():
	yield(get_tree(),"idle_frame")
	var size = get_tree().get_nodes_in_group("P1 Characters").size()
	if size == 0:
		if get_tree().get_nodes_in_group("P2 Characters").size() == 0 :
			print("DRAW!?")
			var timer = get_tree().create_timer(3)
			timer.connect("timeout", get_tree(), "reload_current_scene")
			return
		else:
			print("P2 Wins!!!")
			var timer = get_tree().create_timer(3)
			timer.connect("timeout", get_tree(), "reload_current_scene")
			return
	size = get_tree().get_nodes_in_group("P2 Characters").size()
	if size == 0:
		print("P1 Wins!!!")
		var timer = get_tree().create_timer(3)
		timer.connect("timeout", get_tree(), "reload_current_scene")
		return
