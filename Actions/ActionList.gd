class_name ActionList
extends VBoxContainer

var active: Action = null

func add_action(action: Action):
	var button = Button.new()
	button.text = action.action_name
	button.connect("pressed", self, "set_active", [action])
	if action.shortcut:
		button.shortcut = action.shortcut
	add_child(button)

func set_active(value: Action):
	if active:
		active.active = false
	value.active = true
	active = value
