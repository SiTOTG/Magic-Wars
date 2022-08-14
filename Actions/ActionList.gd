class_name ActionList
extends ScrollContainer

onready var actionList = $ActionList

var active: Action = null

var buttons = {}

func add_action(action: Action):
	var button = Button.new()
	button.text = action.action_name
	button.connect("pressed", self, "set_active", [action])
	if action.shortcut:
		button.shortcut = action.shortcut
	actionList.add_child(button)
	buttons[action] = button

func set_active(value: Action):
	if active and value != active:
		active.active = false
	value.active = true
	active = value

func remove_action(action: Action):
	var button = buttons[action]
	actionList.remove_child(button)
	button.queue_free()
