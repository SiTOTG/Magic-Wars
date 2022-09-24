extends MenuButton

signal player_changed(player)

export (Array, Resource) var players: Array setget set_players

func _ready():
	_setup()
	get_popup().connect("id_pressed", self, "_on_player_id_pressed")

func set_players(value):
	players = value
	_setup()

func _setup():
	if not players:
		text = ""
		get_popup().clear()
		return

	var popup: PopupMenu = get_popup()
	popup.clear()
	text = players[0].player_group
	for player in players:
		player = player as Player
		var menu_item = popup.add_item(player.player_group)

func _on_player_id_pressed(id):
	var player_group = get_popup().get_item_text(id)
	if text == player_group:
		# Selected same player
		return
	for player in players:
		if player.player_group == player_group:
			emit_signal("player_changed", player)
			text = player.player_group
			return
	printerr("No player found, list out of date?")
