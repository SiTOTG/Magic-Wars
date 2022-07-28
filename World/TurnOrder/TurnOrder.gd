extends Control

onready var character_list_ui = $MarginContainer/CharacterList
var character_order := []

func _ready():
	for character_node in get_tree().get_nodes_in_group("Characters"):
		if character_node is CharacterNode:
			character_order.append(character_node)

	character_order.sort_custom(SpeedSorter, "sort_speed")
	update_ui()

func update_ui():
	for child in character_list_ui.get_children():
		character_list_ui.remove_child(child)

	for character_node in character_order:
		var label = Label.new()
		label.text = character_node.character.characterName
		character_list_ui.add_child(label)

class SpeedSorter:
	static func sort_speed(a: CharacterNode, b: CharacterNode):
		return a.character.speed > b.character.speed
