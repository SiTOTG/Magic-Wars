extends Control

const CharacterNodeScene = preload("res://Character/CharacterNode.tscn")
const GameOverScene = preload("res://World/Battle/GameOver/GameOver.tscn")

export (Array, Resource) var actions = []
export (Array, Resource) var players = []

onready var turn_order = $CanvasLayer/TurnOrder
onready var action_list = $CanvasLayer/ActionContainer/ActionList
onready var battle_ui = $CanvasLayer
onready var settingsScreen = $Settings

var game_over: = false
var statistics: BattleStatistics
var characterStatisticsIndex: Dictionary = {}

func _ready():
	statistics = BattleStatistics.new()
	if PlayersInfo.players.size() > 0:
		players = PlayersInfo.players
	for player in players:
		player = player as Player
		var player_statistics = BattleStatistics.PlayerStats.new()
		statistics.players[player.player_group] = player_statistics
		var character_slot_list = $P1 if player.player_group == "P1 Characters" else $P2
		var slot = 0
		for character in player.selected_characters:
			var character_statistics = BattleStatistics.CharacterStats.new()
			player_statistics.character_stats[slot] = character_statistics
			var character_node = CharacterNodeScene.instance()
			character_node.character = character
			character_node.add_to_group(player.player_group)
			character_node.player = player
			character_node.connect("damage_dealt", self, "_on_damage_dealt__collect_statistics")
			characterStatisticsIndex[character_node] = character_statistics
			var character_slot: CharacterSlot = character_slot_list.get_child(slot)
			character_slot.add_child(character_node)
			character_slot.init_ready()
			slot += 1
	for action in actions:
		init_action(action)
		action_list.add_action(action)
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode:
			init_action(character.special.get_action())
			character.connect("death", self, "_check_gameover_condition")
	turn_order.setup()
	action_list.add_action(turn_order.current_turn.special.get_action())

func init_action(action):
	action.characters = get_tree().get_nodes_in_group("Characters")
	action.turn_order = turn_order
	action.ui = $CanvasLayer
	action.connect("finished_action", self, "_on_finished_action")

func _on_finished_action():
	if turn_order.current_turn:
		action_list.remove_action(turn_order.current_turn.special.get_action())
	turn_order.go_to_next_turn()
	if turn_order.current_turn:
		turn_order.current_turn.start_turn()
		action_list.add_action(turn_order.current_turn.special.get_action())

func _on_damage_dealt__collect_statistics(origin: CharacterNode, target: CharacterNode, damage: int):
	var origin_character_stats = characterStatisticsIndex[origin] as BattleStatistics.CharacterStats
	var target_character_stats = characterStatisticsIndex[target] as BattleStatistics.CharacterStats
	if damage > 0:
		origin_character_stats.damage_dealt += damage
		target_character_stats.damage_taken += damage
	elif damage < 0:
		origin_character_stats.damage_healed -= damage

func _check_gameover_condition():
	yield(get_tree(),"idle_frame")
	# await get_tree().idle_frame
	if game_over:
		return
	var size_p1 = get_tree().get_nodes_in_group("P1 Characters").size()
	var size_p2 = get_tree().get_nodes_in_group("P2 Characters").size()
	if size_p1 == 0 and size_p2 == 0:
		game_over = true
		statistics.players["P2 Characters"].winner = true
		statistics.players["P1 Characters"].winner = true
	elif size_p1 == 0:
		game_over = true
		statistics.players["P2 Characters"].winner = true
		statistics.players["P1 Characters"].winner = false
	elif size_p2 == 0:
		game_over = true
		statistics.players["P2 Characters"].winner = false
		statistics.players["P1 Characters"].winner = true
	if game_over:
		var game_over_scene = GameOverScene.instance()
		statistics.number_of_turns = turn_order.turn_number
		game_over_scene.statistics = statistics
		get_tree().root.add_child(game_over_scene)
		visible = false
		battle_ui.visible = false
		game_over_scene.start()
		return


func _on_SettingsButton_pressed():
	settingsScreen.visible = true
	battle_ui.visible = false


func _on_Settings_hide():
	battle_ui.visible = true
