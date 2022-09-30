extends Control

onready var settingsScreen := $Settings

func _on_StartButton_pressed():
	get_tree().change_scene("res://World/Battle/PreBattle/PreBattle.tscn")


func _on_SettingsButton_pressed():
	settingsScreen.visible = true
