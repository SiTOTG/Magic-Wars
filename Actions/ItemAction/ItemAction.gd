class_name ItemAction
extends Action

const Inventory: = preload("res://World/Items/Inventory.tscn")

var inventory: Inventory
var action: Action

func do_apply():
	pass

func do_activate(reactivation):
	if reactivation:
		self.active = false
	else:
		inventory = Inventory.instance()
		ui.add_child(inventory)
		inventory.items = turn_order.current_turn.player.item_slots
	# warning-ignore:return_value_discarded
		inventory.connect("item_selected", self, "_on_item_selected")
	

func _on_item_selected(item: Item):
	self.active = false
	self.action = item.action.duplicate(true)
	self.action.init(self)
# warning-ignore:return_value_discarded
	self.action.connect("finished_action", self, "_on_item_used")

	self.action.active = true

func _on_item_used():
	emit_signal("finished_action")

func do_deactivate():
	if inventory:
		inventory.queue_free()
		inventory = null
