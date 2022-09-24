extends Label

func _setup(player: Player):
	text = str(player.buy_points)

func update_points(points):
	text = str(points)

func _on_SingleCharacterView_character_selected(character, current_points, all_selected_characters):
	update_points(current_points)


func _on_SingleCharacterView_character_unselected(character, current_points, all_selected_characters):
	update_points(current_points)


func _on_SingleItemView_item_selected(item, current_points, current_stack_size, all_selected_items):
	update_points(current_points)


func _on_SingleItemView_item_unselected(item, current_points, current_stack_size, all_selected_item):
	update_points(current_points)
