tool
class_name CharacterSlot
extends Control

var character: CharacterNode = null
var hpbar: TextureRect
var current_hpbar: TextureRect
var nameLabel: Label

func _ready():
	init_ready()

func init_ready():
	hpbar = $hpbar
	current_hpbar = $hpbar/current
	
	for child in get_children():
		if child is CharacterNode:
			init_character(child)
			break


func init_character(child: CharacterNode):
	character = child
	character.centered = false
# warning-ignore:return_value_discarded
	character.connect("hp_updated", self, "_on_hp_updated")
	nameLabel = $NameLabel
	nameLabel.text = character.character.characterName
	update_hp_bar(character.hp, character.character.max_hp)

func _on_hp_updated(hp, max_hp):
	update_hp_bar(hp, max_hp)

func update_hp_bar(hp, max_hp):
	var hp_rate = 1.0*hp/max_hp
	var tween = get_tree().create_tween()
	var before = current_hpbar.rect_size
	var end = Vector2(before)
	end.x = int(hp_rate*hpbar.rect_size.x)
	tween.tween_property(current_hpbar, "rect_size", end, 0.6)

#	current_hpbar.rect_size.x = int(hp_rate*hpbar.rect_size.x)

func _get_configuration_warning():
	for child in get_children():
		if child is CharacterNode:
			if child.centered:
				return "Remove centered in order to fit in the UI"
			return ""
	return "Needs to have a CharacterNode to work."

