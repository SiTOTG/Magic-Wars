extends Node2D

var player = preload("res://Player/P1.tres")

func _ready():
	$Inventory.items = player.items
	$Inventory.connect("item_selected", self, "_on_sel")

func _on_sel(item):
	print(item.item_name)
