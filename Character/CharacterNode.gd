class_name CharacterNode
extends Sprite

export (Resource) var character = preload("res://Character/Dummy/Dummy.tres") as Character

onready var animation_player = $AnimationPlayer
onready var hp = character.max_hp setget set_hp
onready var hp_label = $HP

func set_hp(value):
	hp = value
	hp_label.text = str(hp)

func attack(target: CharacterNode):
	target.hp -= character.damage
