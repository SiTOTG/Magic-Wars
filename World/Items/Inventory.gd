class_name Inventory
extends Control

signal item_selected(item)

onready var slots: = $MarginContainer/Panel/MarginContainer/Slots

export (bool) var CURSOR_AVOID_EMPTY_SLOT = false

var focus: Panel

func _ready():
	focus = slots.get_children()[0]
	focus.focus = true
	for slot in slots.get_children():
		slot.connect("selected_item", self, "_on_item_selected")
		slot.connect("hovered", self, "_on_slot_hovered", [slot])


func _process(delta):
	var origin = focus.get_position_in_parent()
	var pos = origin
	if Input.is_action_just_pressed("ui_accept"):
		if focus and focus.item:
			emit_signal("item_selected", focus.item)
	if Input.is_action_just_pressed("ui_right"):
		pos = (origin + 1) % slots.get_child_count()
	elif Input.is_action_just_pressed("ui_left"):
		pos = origin - 1 if pos > 0 else slots.get_child_count()-1
	elif Input.is_action_just_pressed("ui_up"):
		pos = origin - slots.columns
		if pos < 0:
			pos = slots.get_child_count() + pos
	elif Input.is_action_just_pressed("ui_down"):
		pos = (origin + slots.columns) % slots.get_child_count()
	if origin != pos:
		var new = slots.get_children()[pos]
#		if new.item:
#			focus = new
		update_focus(new)

func update_focus(new):
	focus.focus = false
	new.focus = true
	focus = new

func _on_slot_hovered(slot):
	if slot != focus:
		update_focus(slot)

func _on_item_selected(item):
	item = item as Item
	if not item:
		printerr("Wrong kind of item")
		return
	emit_signal("item_selected", item)
