class_name SpecialNode
extends Node2D

var character

func get_ui() -> Control:
	printerr("Ui not defined")
	return null

func is_available() -> bool:
	return true

func get_action():
	printerr("No action defined")
	return null
