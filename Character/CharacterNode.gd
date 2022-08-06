class_name CharacterNode
extends Sprite

export (Resource) var character = preload("res://Character/Dummy/Dummy.tres") as Character
export (bool) var visible_name: bool = true setget set_name_visibility

onready var animation_player = $AnimationPlayer
onready var hp = character.max_hp setget set_hp
onready var hp_label = $HP
onready var name_label = $Name

signal death

var is_defending = false

func _ready():
	hp_label.text = str(hp)
	name_label.visible = visible_name
	name_label.text = character.characterName

func set_hp(value):
	hp = int(clamp(value, 0, character.max_hp))
	hp_label.text = str(hp)
	if hp == 0:
		emit_signal("death")
		queue_free()


func attack(target: CharacterNode):
	target.do_damage(character.damage)

func do_damage(damage: int):
	if not is_defending:
		self.hp -= damage

func set_name_visibility(value):
	visible_name = value
	name_label.visible = value

func start_turn():
	is_defending = false

func play_animation(animation: String):
	animation_player.play(animation)
	animation_player.queue("Idle")
