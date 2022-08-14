class_name ItemAction
extends Action

const Inventory: = preload("res://World/Items/Inventory.tscn")

var inventory: Inventory
var action: Action

func do_apply():
	pass

func do_activate():
	inventory = Inventory.instance()
	ui.add_child(inventory)
# warning-ignore:return_value_discarded
	inventory.connect("item_selected", self, "_on_item_selected")

func _on_item_selected(item: Item):
	self.active = false
	self.action = item.action.duplicate(true)
	self.action.init(self)

	self.action.active = true
	print(item.item_name)

func do_deactivate():
	if inventory:
		inventory.queue_free()
