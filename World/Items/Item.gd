class_name Item
extends Resource

const dummy = preload("res://Assets/items/dummy.png")

export (Texture) var icon = dummy
export (String) var item_name = "Item"
export (String) var description = "Description"
export (Resource) var action
export (int, 1, 5) var stack_size = 2
export (int, 1, 10) var max_stacks = 5
