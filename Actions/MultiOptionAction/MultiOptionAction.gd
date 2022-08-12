class_name MultiOptionAction
extends Action

const ActionListPackedScene = preload("res://Actions/ActionList.tscn")

var options: Array = [] setget set_options

var actionList: ActionList = null
var vBoxContainer: VBoxContainer = null
var previous_action_list: ActionList

func set_characters(value):
	.set_characters(value)
	for action in options:
		action.characters = value

func set_turnorder(value):
	.set_turnorder(value)
	for action in options:
		action.turn_order = value

func set_ui(value):
	.set_ui(value)
	for action in options:
		action.ui = value

func set_options(value):
	options = value
	for action in options:
		action.connect("finished_action", self, "finish_action")

func add_option(option: Resource):
	options.append(option)
# warning-ignore:return_value_discarded
	option.connect("finished_action", self, "finish_action")

func find_current_action_list() -> ActionList:
	var action_container = ui.find_node("ActionContainer")
	for child in action_container.get_children():
		if child is ActionList and child.visible:
			return child
	printerr("No action list visible!!")
	return null

func do_activate():
	vBoxContainer = VBoxContainer.new()
	actionList = ActionListPackedScene.instance()
	actionList.size_flags_vertical = Control.SIZE_EXPAND_FILL
	previous_action_list = find_current_action_list()
	previous_action_list.visible = false
	var actionContainer = previous_action_list.get_parent()
	actionContainer.add_child(vBoxContainer)
	vBoxContainer.add_child(actionList)
	var backButton = Button.new()
	backButton.connect("pressed", self, "set_active", [false])
	backButton.text = "Back"
	vBoxContainer.add_child(backButton)
	init_actions()

func init_actions():
	for action in options:
		actionList.add_action(action)

func finish_action():
	self.active = false
	emit_signal("finished_action")
	
func do_deactivate():
	for child in actionList.get_children():
		if child is Action:
			actionList.remove_action(child)
	actionList.visible = false
	previous_action_list.visible = true
	previous_action_list.get_parent().remove_child(vBoxContainer)
	actionList.queue_free()
	vBoxContainer.queue_free()
