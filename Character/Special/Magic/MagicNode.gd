extends SpecialNode

onready var action = MultiOptionAction.new()

func _ready():
	action.action_name = "Magic"
	var attack = Attack.new()
	attack.action_name = "Attack All"
	attack.selector = AllTargetSelector.new()
	action.add_option(attack)

func get_action():
	return action
