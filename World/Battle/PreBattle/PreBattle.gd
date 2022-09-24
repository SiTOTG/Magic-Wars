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

# warning-ignore:shadowed_variable
func _on_SelectPlayerMenu_player_changed(player):
	self.player = player
	setup()


func _on_StartBattleButton_pressed():
	PlayersInfo.players = $SelectPlayerMenu.players
	var players_less_than_4 = []
# warning-ignore:shadowed_variable
	for player in PlayersInfo.players:
		player = player as Player
		if player.selected_characters.size() < 4:
			players_less_than_4.append(player.player_group)
	if players_less_than_4.size() > 0:
		var players_formatted = ", ".join(players_less_than_4)
		var dialog = AcceptDialog.new()
		dialog.dialog_text = "Players (%s) have less than 4 characters, are you sure you want to start the battle?" % (players_formatted)
		add_child(dialog)
		dialog.popup_centered()
		dialog.connect("confirmed", self, "_start_battle")
	else:
		_start_battle()

func _start_battle():
	var err = get_tree().change_scene("res://World/Battle/Battle.tscn")
	if err != OK:
		printerr("Failed to start battle due to error number %d" % err)
