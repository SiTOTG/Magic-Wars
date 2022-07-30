class_name Selector
extends Resource

var origin: CharacterNode
var characters: Array
var turn_order: TurnOrder
var ui: CanvasLayer

signal finished_selection(characters)

func _init():
	self.connect("finished_selection", self, "_on_finish_selection")

func start_selection():
	printerr("Start selection not implemented")

func clear_selection():
	printerr("Clear selection not implemented")

func _on_finish_selection(selected):
	self.clear_selection()
