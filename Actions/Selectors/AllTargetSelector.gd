class_name AllTargetSelector
extends Selector


export (bool) var should_confirm: = true

var confirm_button
const ConfirmButton = preload("res://Actions/Selectors/ConfirmButton.tscn")
const default_include = preload("res://Actions/Selectors/Targets/Enemy.tres")

func _init():
	confirm_button = ConfirmButton.instance()
	confirm_button.text = "Confirm Attack All"
	confirm_button.connect("pressed", self, "_confirm_callback")

func start_selection():
	if not self.ui:
		return
	if should_confirm:
		var confirm_box = self.ui.find_node("ConfirmBox")
		if not confirm_button in confirm_box.get_children():
			confirm_box.add_child(confirm_button)
	else:
		finish_selection()

func clear_selection():
	if not self.ui:
		return
	var confirm_box = self.ui.find_node("ConfirmBox")
	if confirm_button in confirm_box.get_children():
		confirm_box.remove_child(confirm_button)

func finish_selection():
	var targets = get_candidates()
	if not targets:
		targets = default_include.get_targets()

	emit_signal("finished_selection", targets)

func _confirm_callback():
	finish_selection()
