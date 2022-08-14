tool
extends Panel

export (Resource) var item_slot setget set_item

signal selected_item(item)
signal hovered

var hovering: = false
var focus: = false setget set_focus

func _ready():
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
	if item_slot and $Icon:
		$Icon.texture = item_slot.item.icon

func set_item(value):
	if value and get_node_or_null("Icon"):
		$Icon.texture = value.item.icon
	item_slot = value

func set_focus(value):
	focus = value
	update()

func _on_mouse_entered():
	hovering = true
	emit_signal("hovered")

func _on_mouse_exited():
	hovering = false

func _input(event):
	if event is InputEventMouseButton\
		and event.button_index == BUTTON_LEFT\
		and event.pressed\
		and item_slot\
		and hovering:
		emit_signal("selected_item", item_slot.item)
	elif event is InputEventMouseMotion and hovering and not focus:
		emit_signal("hovered")

func _draw():
	if focus:
		var rect = Rect2(Vector2.ZERO, rect_size)
		draw_rect(rect, Color.white, false, 3.0)
