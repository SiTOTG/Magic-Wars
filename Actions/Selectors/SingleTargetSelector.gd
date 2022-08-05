class_name SingleTargetSelector
extends Selector

var temp_buttons = []

func start_selection():
	var inclusion = []
	if not include:
		inclusion = GlobalTree.get_tree().get_nodes_in_group("Characters")
	else:
		for target in include:
			target = target as Target
			for character in target.get_targets():
				if not character in inclusion:
					inclusion.append(character)
	for character in inclusion:
		if character is CharacterNode:
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
