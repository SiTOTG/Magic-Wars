extends Panel

export (Resource) var player = preload("res://Player/P1.tres") setget set_player
export var current := 0

signal item_selected(item, current_points, current_stack_size, all_selected_items)
signal item_unselected(item, current_points, current_stack_size, all_selected_item)
signal item_batch_update(selected_items)

onready var items = player.item_slots

onready var add_button = $Add
onready var remove_button = $Remove

func set_player(value):
	player = value
	if player:
		items = player.item_slots
	current = 0
	var selected_items = []
	for item in player.item_slots:
		if item.stacks > 0:
			selected_items.append(item)
	emit_signal("item_batch_update", selected_items)
	update()

func _ready():
	update()

func update():
	if current < 0:
		printerr("Trying to update but out of range")
		return

	var item: ItemSlot = items[current]
	$Panel/TextureRect.texture = item.item.icon
	$Panel/Description.text = item.item.description
	$Panel/Stacks.text = str(item.stacks)
	for property in item.item.get_property_list():
		var field = self.find_node(property.name)
		if not field:
			continue
		var fieldValue: Label = field.get_node("FieldValue")
		fieldValue.text = str(item.item.get(property.name))

	update_add_button_availability(item)
	update_remove_button_availability(item)

func update_add_button_availability(item: ItemSlot):
	add_button.disabled = not _can_buy_item(item)
	
func update_remove_button_availability(item: ItemSlot):
	remove_button.disabled = (item.stacks <= 0)

func _on_Left_pressed():
	if current == 0:
		current = items.size() - 1
	else:
		current -= 1
	update()


func _on_Right_pressed():
	current = (current + 1) % items.size()
	update()


func _on_Add_pressed():
	var item: ItemSlot = items[current]
	if _can_buy_item(item):
		item.stacks += 1
		player.buy_points -= 1
		emit_signal("item_selected", item, player.buy_points, item.stacks, items)
	update()

func _on_Remove_pressed():
	var item: ItemSlot = items[current]
	if item.stacks > 0:
		item.stacks -= 1
		player.buy_points += 1
		emit_signal("item_unselected", item, player.buy_points, item.stacks, items)
	update()

func _can_buy_item(item: ItemSlot):
	return(item.stacks < item.item.max_stacks and player.buy_points > 0)
