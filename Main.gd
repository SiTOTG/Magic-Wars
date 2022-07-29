extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn_order = $CanvasLayer/TurnOrder

var temp_buttons = []

func _on_NextTurn_pressed():
	next_turn()

func _on_Attack_pressed():
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode and character != turn_order.current_turn:
			var button = Button.new()
			button.rect_position = character.get_node("Top").global_position
			button.text = "Target"

			get_node("CanvasLayer").add_child(button)
			button.connect("pressed", turn_order.current_turn, "attack", [character])
			button.connect("pressed", self, "next_turn")
			temp_buttons.append(button)

func next_turn():
	for button in temp_buttons:
		button.queue_free()
	temp_buttons.clear()
	turn_order.go_to_next_turn()
