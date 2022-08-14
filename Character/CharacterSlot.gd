tool
class_name CharacterSlot
extends Control

var character: CharacterNode = null
var hpbar: BarUI
var mpbar: BarUI
var current_hpbar: TextureRect
var nameLabel: Label

func _ready():
	init_ready()

func init_ready():
	hpbar = $hpbar
	mpbar = $SpecialContainer/VBoxContainer/mpbar
	
	for child in get_children():
		if child is CharacterNode:
			init_character(child)
			break

func init_character(child: CharacterNode):
	character = child
	character.centered = false
# warning-ignore:return_value_discarded
	character.connect("hp_updated", hpbar, "update_bar")
# warning-ignore:return_value_discarded
	character.connect("mp_updated", mpbar, "update_bar")
	nameLabel = $NameLabel
	nameLabel.text = character.character.characterName
	hpbar.call_deferred("update_bar", character.hp, character.character.max_hp)
	mpbar.call_deferred("update_bar", character.mp, character.character.max_mp)

#	current_hpbar.rect_size.x = int(hp_rate*hpbar.rect_size.x)

func _get_configuration_warning():
	for child in get_children():
		if child is CharacterNode:
			if child.centered:
				return "Remove centered in order to fit in the UI"
			return ""
	return "Needs to have a CharacterNode to work."

