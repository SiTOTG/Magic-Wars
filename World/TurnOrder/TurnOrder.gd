extends Control

onready var character_list_ui = $ListArea/CharacterList
onready var current_turn_indicator = $CurrentTurnIndicator
var Players := {
	"P1 Characters" : {"TurnOrder": [],
		"CurrentTurn": 0},
	"P2 Characters" : {"TurnOrder": [],
		"CurrentTurn": 0}
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
	var max_characters = 0
	for player_name in Players:
		var player = Players[player_name]
		var n = player.TurnOrder.size()
		if n > max_characters: max_characters = n
	
	for i in range(max_characters*2):
		var player = player_order[i%2]
		var character = int(floor(i/2))%Players[player].TurnOrder.size()
		var character_node = Players[player].TurnOrder[character]
		print("Adding character %s" % character_node.character.characterName)
		global_turn_order.append(character_node)

func update_ui():
	for child in character_list_ui.get_children():
		character_list_ui.remove_child(child)
	
	for character_node in global_turn_order:
		var label = Label.new()
		label.text = character_node.character.characterName
		character_list_ui.add_child(label)
	
	update_turn_ui()

func get_player(character : CharacterNode):
	for group in character.get_groups():
		if group in Players:
			return group	
	return null

func get_next_player(player: String):
	for player_name in Players:
		if player_name != player:
			return player_name
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
	var next_player = get_next_player(get_player(current_turn))
	var player_dict = Players[next_player]
	player_dict.CurrentTurn = (player_dict.CurrentTurn + 1) % player_dict.TurnOrder.size()
	current_turn = player_dict.TurnOrder[player_dict.CurrentTurn]
	update_turn_ui()
