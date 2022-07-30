class_name TurnOrder
extends Control

onready var character_list_ui = $ListArea/CharacterList
onready var current_turn_indicator = $CurrentTurnIndicator

var players = {
	"P1 Characters" : Player.new(),
	"P2 Characters" : Player.new()
}

var current_turn: CharacterNode = null
var player_order: Array = []
var global_turn_order: Array = []

export (int, 1, 20) var max_display_turns = 8

func _ready():
	for group in players:
		for character_node in get_tree().get_nodes_in_group(group):
			if character_node is CharacterNode:
				players[group].add_character(character_node)
				character_node.connect("death", self, "_on_character_death", [character_node])

		players[group].turn_order.sort_custom(SpeedSorter, "sort_speed")

	if players["P1 Characters"].get_top_speed() > players["P2 Characters"].get_top_speed():
		current_turn = players["P1 Characters"].get_current()
		player_order = ["P1 Characters", "P2 Characters"]
	else:
		current_turn = players["P2 Characters"].get_current()
		player_order = ["P2 Characters", "P1 Characters"]
	calculate_turn_order()
	update_ui()
	
func calculate_turn_order():
	global_turn_order.clear()

	if players["P1 Characters"].get_number_of_characters() == 0:
		global_turn_order = players["P2 Characters"].turn_order.duplicate()
		return
	if players["P2 Characters"].get_number_of_characters() == 0:
		global_turn_order = players["P1 Characters"].turn_order.duplicate()
		return
	var p1 = players["P1 Characters"].copy()
	var p2 = players["P2 Characters"].copy()
	var current_idx = player_order.find(get_player(current_turn))
	for i in range(current_idx,max_display_turns+current_idx):
		var player_name = player_order[i % player_order.size()]
		if player_name == "P1 Characters":
			global_turn_order.append(p1.get_current())
		else:
			global_turn_order.append(p2.get_current())
			p1.go_to_next_turn()
			p2.go_to_next_turn()

func update_ui():
	for child in character_list_ui.get_children():
		character_list_ui.remove_child(child)
	
	for character_node in global_turn_order:
		var label = Label.new()
		label.text = character_node.character.characterName
		character_list_ui.add_child(label)
	
	update_turn_ui()

func get_player(character : CharacterNode) -> String:
	for group in character.get_groups():
		if group in players:
			return group
	printerr("Non-existing player!")
	return ""

func get_next_player(player: String) -> String:
	for player_name in players:
		if player_name != player:
			return player_name
	printerr("Non-existing player!")
	return ""

func update_turn_ui():
	if current_turn:
		current_turn_indicator.global_position = current_turn.global_position
		current_turn_indicator.visible = true
	else:
		current_turn_indicator.visible = false

class SpeedSorter:
	static func sort_speed(a: CharacterNode, b: CharacterNode):
		return a.character.speed > b.character.speed

func go_to_next_turn():
	if not current_turn:
		return
	var next_player = get_next_player(get_player(current_turn))
	if next_player == player_order[0]:
		for player in players:
			players[player].go_to_next_turn()
	current_turn = players[next_player].get_current()
	calculate_turn_order()
	update_ui()

func _on_character_death(character: CharacterNode):
	var player_name = get_player(character)
	var player: Player = players[player_name]
	player.remove_character(character)
	if player_name == get_player(current_turn):
		current_turn = player.get_current()
	calculate_turn_order()
	update_ui()

class Player:
	var turn_order: Array = []
	var current: int = 0
	
	func add_character(value: CharacterNode):
		turn_order.append(value)
		
	func get_top_speed():
		if turn_order.size() == 0:
			return
		return turn_order[0].character.speed
	
	func get_current():
		if turn_order.size() == 0:
			return
		return turn_order[current]
	
	func get_number_of_characters():
		return turn_order.size()
	
	func go_to_next_turn():
		if turn_order.size() == 0:
			return
		current = (current +1) % turn_order.size()

	func remove_character(character: CharacterNode):
		var pos = turn_order.find(character)
		if pos < current:
			current -= 1
		turn_order.remove(pos)
		if turn_order.size() == 0:
			return
		current = current % turn_order.size()
		return current

	func copy() -> Player:
		var new = Player.new()
		new.turn_order = turn_order.duplicate()
		new.current = current
		return new
