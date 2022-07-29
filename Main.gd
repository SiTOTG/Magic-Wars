extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn_order = $CanvasLayer/TurnOrder

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_NextTurn_pressed():
	turn_order.go_to_next_turn()

func _on_Attack_pressed():
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode and character != turn_order.current_turn:
			var button = Button.new()
			button.rect_position = character.global_position
			get_node("CanvasLayer").add_child(button)
			var target_button: Button = character.get_node("Target")
			target_button.visible = true
			target_button.connect("pressed", turn_order.current_turn, "attack", [character])
