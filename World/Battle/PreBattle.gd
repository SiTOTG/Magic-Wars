extends Control

const Battle = preload("res://World/Battle/Battle.tscn")

var player: Player
onready var pointsLabel := $Overlay/OverlayItems/PointsLabel
onready var itemView := $Selector/Inventory/ItemSelector/SingleItemView
onready var characterView := $Selector/Party/CharacterSelector/SingleCharacterView

func _ready():
	# Default, just in case it wasn't provided
	player = preload("res://Player/P1.tres")
	setup()

func setup():
	itemView.player = player
	pointsLabel._setup(player)
	characterView.player = player

func _on_SelectPlayerMenu_player_changed(player):
	self.player = player
	setup()


func _on_StartBattleButton_pressed():
	PlayersInfo.players = $SelectPlayerMenu.players
	get_tree().change_scene("res://World/Battle/Battle.tscn")
