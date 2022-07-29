class_name CharacterNode
extends Sprite

export (Resource) var character = preload("res://Character/Dummy/Dummy.tres") as Character

onready var animation_player = $AnimationPlayer
onready var hp = character.max_hp setget set_hp
onready var hp_label = $HP

signal death

func _ready():
	hp_label.text = str(hp)

func set_hp(value):
	hp = int(clamp(value, 0, character.max_hp))
	hp_label.text = str(hp)
	if hp == 0:
		emit_signal("death")
		queue_free()


func attack(target: CharacterNode):
	target.hp -= character.damage
