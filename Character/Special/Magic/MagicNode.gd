extends SpecialNode

onready var action = MultiOptionAction.new()

func _ready():
	action.action_name = "Magic"
	action.options.append(load("res://Actions/DummyAttackAll.tres"))

func get_action():
	return action
