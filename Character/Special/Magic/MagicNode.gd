extends SpecialNode

onready var action = MultiOptionAction.new()

func _ready():
	action.action_name = "Magic"
	action.add_option(load("res://Actions/DummyAttackAll.tres").duplicate(true))
	action.add_option(load("res://Actions/Spells/DummySpell.tres").duplicate(true))

func get_action():
	return action
