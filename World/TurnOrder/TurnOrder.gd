extends Control

onready var character_list_ui = $ListArea/CharacterList
onready var current_turn_indicator = $CurrentTurnIndicator
var character_order := []
var current_turn: CharacterNode = null

func _ready():
	for character_node in get_tree().get_nodes_in_group("Characters"):
		if character_node is CharacterNode:
			character_order.append(character_node)

	character_order.sort_custom(SpeedSorter, "sort_speed")
	current_turn = character_order[0]
	update_ui()

func update_ui():
	for child in character_list_ui.get_children():
		character_list_ui.remove_child(child)

	for character_node in character_order:
		var label = Label.new()
		label.text = character_node.character.characterName
		character_list_ui.add_child(label)
	
	update_turn_ui()

func update_turn_ui():
	if current_turn:
		current_turn_indicator.global_position = current_turn.global_position
		current_turn_indicator.visible = true
	else:
		current_turn_indicator.visible = false

class SpeedSorter:
	static func sort_speed(a: CharacterNode, b: CharacterNode):
		return a.character.speed > b.character.speed

func _on_NextTurnButton_pressed():
	var idx = (character_order.find(current_turn) + 1) % character_order.size()
	current_turn = character_order[idx]
	update_turn_ui()
