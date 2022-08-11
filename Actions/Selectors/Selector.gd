class_name Selector
extends Resource

var origin: CharacterNode
var characters: Array
var turn_order: TurnOrder setget set_turnorder
var ui: CanvasLayer

export (Array, Resource) var exclude = []
export (Array, Resource) var include = []

# warning-ignore:unused_signal
signal finished_selection(characters)

func set_turnorder(value):
	turn_order = value
	for inclusion in include:
		inclusion = inclusion as Target
		inclusion.turn_order = value

func _init():
	# warning-ignore:return_value_discarded
	self.connect("finished_selection", self, "_on_finish_selection")

func get_candidates() -> Array:
	var inclusion = []
	for target in include:
		target = target as Target
		for character in target.get_targets():
			if not character in inclusion:
				inclusion.append(character)
	# TODO: Exclude
	return inclusion

func start_selection():
	printerr("Start selection not implemented")

func clear_selection():
	printerr("Clear selection not implemented")

func _on_finish_selection(_selected):
	self.clear_selection()
