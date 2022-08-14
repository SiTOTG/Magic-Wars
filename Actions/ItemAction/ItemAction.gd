class_name ItemAction
extends Action

const Inventory: = preload("res://World/Items/Inventory.tscn")

var inventory: Inventory

func do_apply():
	pass

func do_activate():
	inventory = Inventory.instance()
	
	ui.add_child(inventory)
	inventory.connect("item_selected", self, "_on_item_selected")
	
func _on_item_selected(item: Item):
	self.active = false
	print(item.item_name)

func do_deactivate():
	if inventory:
		inventory.queue_free()
