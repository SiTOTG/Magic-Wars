extends Control

const ScoreItemScene = preload("res://World/Battle/GameOver/ScoreItem.tscn")

onready var timer := $Timer
onready var scoreList := $Panel/ScrollContainer/ScoreList
onready var winnerItemValue := $Panel/ScrollContainer/ScoreList/WinnerItem/Value

var statistics: BattleStatistics
var scores_to_show = []

func add_score_item(score: Score):
	var score_item = ScoreItemScene.instance()
	score_item.get_node("Name").text = score.name
	score_item.get_node("Value").text = score.value
	scoreList.add_child(score_item)

func start():
	var winner = ""
	for player_group in statistics.players:
		var player = statistics.players[player_group] as BattleStatistics.PlayerStats
		if player.winner:
			if not winner:
				winner = player_group
			else:
				winner = "Draw"
		scores_to_show.append(Score.new(
			"Damage dealt by " + player_group,
			player.damage_dealt_total
		))
		scores_to_show.append(Score.new(
			"Damage healed by " + player_group,
			player.damage_healed_total
		))
	winnerItemValue.text = winner
	scores_to_show.append(Score.new(
		"Number of turns",
		statistics.number_of_turns
	))

	timer.start()

class Score:
	var name: String
	var value: String

	func _init(name, value):
		self.name = name
		self.value = value


func _on_Timer_timeout():
	if scores_to_show.size() > 0:
		var score = scores_to_show.pop_front()
		add_score_item(score)
	else:
		timer.stop()


func _on_MainMenu_pressed():
	get_tree().change_scene("res://World/MainMenu/MainMenu.tscn")
	queue_free()


func _on_RestartBattle_pressed():
	get_tree().reload_current_scene()
	queue_free()


func _on_CharacterSelect_pressed():
	get_tree().change_scene("res://World/Battle/PreBattle/PreBattle.tscn")
	queue_free()
