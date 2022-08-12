class_name SingleTargetSelector
extends Selector

var temp_buttons = []

func start_selection():
	var inclusion = []
	if not include:
		inclusion = GlobalTree.get_tree().get_nodes_in_group("Characters")
	else:
		inclusion.append_array(get_candidates())
	for character in inclusion:
		if character is CharacterNode:
			var button = Button.new()
			var char_ui = character.get_parent() as CharacterSlot
			if char_ui:
				var button_position = char_ui.get_node("TargetButtonPosition") as ReferenceRect
				button.set_global_position(button_position.get_global_rect().position)
			else:
				button.rect_position = character.get_node("Top").global_position
			ui.add_child(button)
#			button.rect_position = character.get_node("Top").global_position
#			ui.add_child(button)
			button.text = "Target"
			
			if inclusion.size() == 1:
				button.shortcut = ShortCut.new()
				button.shortcut.shortcut = InputEventAction.new()
				button.shortcut.shortcut.action = "ui_accept"
			button.connect("pressed", self, "selection_callback", [character])
			temp_buttons.append(button)

func clear_selection():
	for button in temp_buttons:
		button.queue_free()
	temp_buttons.clear()

func selection_callback(selected):
	emit_signal("finished_selection", [selected])
