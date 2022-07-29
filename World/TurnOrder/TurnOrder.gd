extends Control

onready var character_list_ui = $ListArea/CharacterList
onready var current_turn_indicator = $CurrentTurnIndicator
var Players := {
	"P1 Characters" : {"TurnOrder": [],
		"CurrentTurn": null},
	"P2 Characters" : {"TurnOrder": [],
		"CurrentTurn": null}
	
}
var current_turn: CharacterNode = null
var player_order: Array = []
var global_turn_order: Array = []

export (int, 1, 20) var max_display_turns = 16

func _ready():
	for group in Players:
		for character_node in get_tree().get_nodes_in_group(group):
			if character_node is CharacterNode:
				Players[group].TurnOrder.append(character_node)

		Players[group].TurnOrder.sort_custom(SpeedSorter, "sort_speed")
	#Decide if character_order_1[0] or character_order_2[0] is faster 
	if Players["P1 Characters"].TurnOrder[0].character.speed > Players["P2 Characters"].TurnOrder[0].character.speed:
		current_turn = Players["P1 Characters"].TurnOrder[0]
		player_order = ["P1 Characters", "P2 Characters"]
	else:
		current_turn = Players["P2 Characters"].TurnOrder[0]
		player_order = ["P2 Characters", "P1 Characters"]
	calculate_turn_order()
	update_ui()
	
func calculate_turn_order():
	global_turn_order.clear()
	for i in range(max_display_turns):
		var player = player_order[i%2]
		var character = int(floor(i/2))%Players[player].TurnOrder.size()
		global_turn_order.append(Players[player].TurnOrder[character])

func update_ui():
	var first_player = get_player(current_turn)
	for child in character_list_ui.get_children():
		character_list_ui.remove_child(child)
	
	for character_node in global_turn_order:
		var label = Label.new()
		label.text = character_node.character.characterName
		character_list_ui.add_child(label)
	
	#for character in group("Characters")  
#	for character_node in character_order:
#		var label = Label.new()
#		label.text = character_node.character.characterName
#		character_list_ui.add_child(label)
	
	update_turn_ui()

func get_player(character : CharacterNode):
	for group in character.get_groups():
		if group in Players:
			return group	
	return null


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
	var idx = (global_turn_order.find(current_turn) + 1) % global_turn_order.size()
	current_turn = global_turn_order[idx]
	update_turn_ui()
