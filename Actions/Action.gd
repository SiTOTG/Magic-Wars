class_name Action
extends Resource

signal finished_action

export (Resource) var selector = preload("res://Actions/Selectors/SingleTargetSelector.tres") as Selector setget set_selector
var characters: Array setget set_characters
var turn_order: TurnOrder setget set_turnorder
var ui: CanvasLayer setget set_ui

func set_characters(value):
	characters = value
	selector.characters = value

func set_turnorder(value):
	turn_order = value
	selector.turn_order = value

func set_ui(value):
	ui = value
	selector.ui = value

func _init():
	if selector:
		selector.characters = characters
		selector.turn_order = turn_order
		selector.ui = ui

func _apply_action(targets: Array):
	do_apply_action(targets)
	emit_signal("finished_action")

func do_apply_action(targets: Array):
	printerr("Action not implemented...")

func set_selector(value):
	selector = value
	selector.connect("finished_selection", self, "_apply_action")
