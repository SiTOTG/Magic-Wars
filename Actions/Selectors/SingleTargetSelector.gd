class_name SingleTargetSelector
extends Selector

export (Array, Resource) var exceptions = []

var temp_buttons = []

func start_selection():
	for character in characters:
		if character is CharacterNode and character != turn_order.current_turn:
			var button = Button.new()
			button.rect_position = character.get_node("Top").global_position
			button.text = "Target"
			ui.add_child(button)
			button.connect("pressed", self, "selection_callback", [character])
			temp_buttons.append(button)

func clear_selection():
	for button in temp_buttons:
		button.queue_free()
	temp_buttons.clear()

func selection_callback(selected):
	emit_signal("finished_selection", [selected])
