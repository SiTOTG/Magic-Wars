class_name Action
extends Resource

signal finished_action

export (Resource) var selector = preload("res://Actions/Selectors/SingleTargetSelector.tres") as Selector setget set_selector
var characters: Array setget set_characters
var turn_order: TurnOrder setget set_turnorder
var ui: CanvasLayer setget set_ui
export (bool) var active: bool = false setget set_active
export (String) var action_name = "Action"
export (ShortCut) var shortcut

func set_characters(value):
	characters = value
	selector.characters = value

func set_turnorder(value):
	turn_order = value
	selector.turn_order = value

func set_ui(value):
	ui = value
	selector.ui = value

func set_selector(value):
	selector = value
	selector.connect("finished_selection", self, "_apply_action")

func _init():
	if selector:
		selector.characters = characters
		selector.turn_order = turn_order
		selector.ui = ui

func init(action):
	self.characters = action.characters
	self.turn_order = action.turn_order
	self.ui = action.ui

func set_active(value):
	var reactivation = value == active
	active = value
	if active:
		do_activate(reactivation)
	else:
		do_deactivate()

func _apply_action(targets: Array):
	do_apply_action(targets)
	self.active = false
	emit_signal("finished_action")


## Extension points
func do_activate(reactivation: bool):
	if reactivation: return
	selector.start_selection()

func do_deactivate():
	selector.clear_selection()

# warning-ignore:unused_argument
func do_apply_action(targets: Array):
	printerr("Action not implemented...")
	
func is_available() -> bool:
	return true
