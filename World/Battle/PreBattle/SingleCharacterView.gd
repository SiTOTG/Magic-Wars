extends Panel

export (Resource) var player = preload("res://Player/P1.tres") setget set_player
export var current := 0

signal character_selected(character, current_points, all_selected_characters)
signal character_unselected(character, current_points, all_selected_characters)
signal character_batch_update(selected_characters)

onready var characters = player.characters
onready var selected_characters = player.selected_characters

onready var select_button = $Select

func set_player(value):
	player = value
	if player:
		characters = player.characters
		selected_characters = player.selected_characters
	emit_signal("character_batch_update", selected_characters)
	current = 0
	update()

func _ready():
	update()

func update():
	if current < 0 or current >= characters.size():
		printerr("Trying to update but out of range")
		return

	var character: Character = characters[current]
	for property in character.get_property_list():
		var field = self.find_node(property.name)
		if not field:
			continue
		var fieldValue: Label = field.get_node("FieldValue")
		fieldValue.text = str(character.get(property.name))

	select_button.text = "Select" if not character in selected_characters else "Unselect"
	update_select_button_availability(character)

func update_select_button_availability(character: Character):
	select_button.disabled = false
	if character in selected_characters:
		# Will always be enabled if character is selected
		return
	if selected_characters.size() > 3 or character.point_cost > player.buy_points:
		select_button.disabled = true
	
	

func _on_Left_pressed():
	if current == 0:
		current = characters.size() - 1
	else:
		current -= 1
	update()


func _on_Right_pressed():
	current = (current + 1) % characters.size()
	update()


func _on_Select_pressed():
	var character: Character = characters[current]
	if character in selected_characters:
		selected_characters.remove(selected_characters.find(character))
		player.buy_points += character.point_cost
		emit_signal("character_unselected", character, player.buy_points, selected_characters)
	elif selected_characters.size() < 4 and player.buy_points >= character.point_cost:
		selected_characters.append(character)
		player.buy_points -= character.point_cost
		emit_signal("character_selected", character, player.buy_points, selected_characters)
	update()
