class_name CharacterNode
extends Sprite

export (Resource) var character = preload("res://Character/Dummy/Dummy.tres") as Character

onready var animation_player = $AnimationPlayer
onready var hp = character.max_hp setget set_hp
onready var mp = character.max_mp setget set_mp
onready var specials = $Specials

signal death
signal hp_updated(curhp, maxhp)
signal mp_updated(curmp, maxmp)
#signal cd_updated()

# warning-ignore:export_hint_type_mistmatch
export (NodePath) onready var special_path = "Specials/Magic" setget set_special

var special: SpecialNode
var is_defending = false

func _ready():
	for special_node in specials.get_children():
		special_node.character = character
	special = get_node(special_path)

func set_hp(value):
	hp = int(clamp(value, 0, character.max_hp))
	emit_signal("hp_updated", hp, character.max_hp)
	if hp == 0:
		emit_signal("death")
		queue_free()

func set_mp(value):
	mp = int(clamp(value, 0, character.max_mp))
	emit_signal("mp_updated", mp, character.max_mp)

func attack(target: CharacterNode, var flat_damage: int, var damage_scale: int):
	target.do_damage(flat_damage+damage_scale*character.damage)

func do_damage(damage: int):
	if not is_defending:
		self.hp -= damage

func start_turn():
	is_defending = false

func play_animation(animation: String):
	animation_player.play(animation)
	animation_player.queue("Idle")

func set_special(value):
	special_path = value
	special = get_node_or_null(value)
	
func check_mp(value):
	return value <= mp
	
func cast_spell():
	pass
