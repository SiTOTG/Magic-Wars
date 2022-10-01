extends Control

const GameOverScene = preload("res://World/Battle/GameOver/GameOver.tscn")

var statistics = BattleStatistics.new()

func _ready():
	yield(get_tree(), "idle_frame")
	var game_over_scene = GameOverScene.instance()
	statistics.number_of_turns = 4
	var p1 = BattleStatistics.PlayerStats.new()
	p1.winner = false
	var char_stats = BattleStatistics.CharacterStats.new()
	char_stats.alive = false
	char_stats.damage_taken = 6
	char_stats.damage_dealt = 2
	char_stats.damage_healed = 0
	p1.character_stats[0] = char_stats
	var p2 = BattleStatistics.PlayerStats.new()
	char_stats = BattleStatistics.CharacterStats.new()
	char_stats.alive = true
	char_stats.damage_taken = 2
	char_stats.damage_dealt = 6
	char_stats.damage_healed = 0
	p2.character_stats[0] = char_stats
	p2.winner = true
	statistics.players["P1 Characters"] = p1
	statistics.players["P2 Characters"] = p2
	game_over_scene.statistics = statistics
	get_tree().root.add_child(game_over_scene)
	visible = false
	game_over_scene.start()
