extends HBoxContainer

func update_preview(characters):
	for i in range(4):
		var textureRect: TextureRect = get_children()[i].get_node("TextureRect")
		if i < characters.size():
			var character: Character = characters[i]
			textureRect.texture = character.icon
		else:
			textureRect.texture = null

func _on_SingleCharacterView_character_selected(character: Character, current_points, all_selected_characters):
	update_preview(all_selected_characters)


func _on_SingleCharacterView_character_unselected(character, current_points, all_selected_characters):
	update_preview(all_selected_characters)


func _on_SingleCharacterView_character_batch_update(selected_characters):
	update_preview(selected_characters)
