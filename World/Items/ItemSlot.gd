class_name ItemSlot
extends Resource

const default = preload("res://World/Items/Dummy.tres")

export (Resource) var item = default
export (int, 0, 99) var remaining = 0
