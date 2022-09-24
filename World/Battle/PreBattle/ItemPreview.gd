extends HBoxContainer

var item_list = []

func update_preview(item: ItemSlot, current_stack_size: int):
	if current_stack_size == 0:
		# Remove
		var pos = item_list.find(item)
		item_list.remove(pos)
	else:
		# Add
		var pos = item_list.find(item)
		if pos == -1:
			item_list.append(item)
		item.stacks = current_stack_size

	update_ui()

func update_ui():
	for i in range(get_child_count()):
		var slot: ItemSlotUI = get_children()[i]
		if i >= item_list.size():
			slot.item_slot = null
			continue
		var cur_item: ItemSlot = item_list[i]
		slot.item_slot = cur_item
		slot.item_slot.remaining = cur_item.item.stack_size * cur_item.stacks

func _on_SingleItemView_item_selected(item: ItemSlot, _current_points, current_stack_size: int, _all_selected_items):
	update_preview(item, current_stack_size)


func _on_SingleItemView_item_unselected(item: ItemSlot, _current_points, current_stack_size: int, _all_selected_item):
	update_preview(item, current_stack_size)


func _on_SingleItemView_item_batch_update(selected_items):
	item_list = selected_items
	update_ui()
