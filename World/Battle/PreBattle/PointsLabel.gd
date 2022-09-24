extends Label

func _setup(player: Player):
	text = str(player.buy_points)

func update_points(points):
	text = str(points)

func _on_SingleCharacterView_character_selected(_character, current_points, _all_selected_characters):
	update_points(current_points)


func _on_SingleCharacterView_character_unselected(_character, current_points, _all_selected_characters):
	update_points(current_points)


func _on_SingleItemView_item_selected(_item, current_points, _current_stack_size, _all_selected_items):
	update_points(current_points)


func _on_SingleItemView_item_unselected(_item, current_points, _current_stack_size, _all_selected_item):
	update_points(current_points)
