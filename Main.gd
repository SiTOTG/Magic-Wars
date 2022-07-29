extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn_order = $CanvasLayer/TurnOrder
onready var defend_button = $CanvasLayer/MarginContainer/VBoxContainer/Defend

enum Action{
	Attack,
	Defense,
	Magic
}

var temp_buttons = []
var status = Action.Attack setget set_status

func _ready():
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode:
			character.connect("death", self, "_check_gameover_condition")
	force_apply_status()

func set_status(value):
	var old_status = status
	status = value
	if status != old_status:
		match old_status:
			Action.Attack:
				clear_temp_buttons()
			Action.Defense:
				defend_button.text = "Defend"

		force_apply_status()

func force_apply_status():
	match status:
		Action.Defense:
			defend_button.text = "Confirm Defend"
		Action.Attack:
			attack_status()

func defend_status():
	status = Action.Defense
	defend_button.text = "Confirm Defend"

func _on_Defend_pressed():
	if status == Action.Defense:
		turn_order.current_turn.is_defending = true
		next_turn()
		return
	self.status = Action.Defense

func _on_Attack_pressed():
	self.status = Action.Attack

func attack_status():
	for character in get_tree().get_nodes_in_group("Characters"):
		if character is CharacterNode and character != turn_order.current_turn:
			var button = Button.new()
			button.rect_position = character.get_node("Top").global_position
			button.text = "Target"

			get_node("CanvasLayer").add_child(button)
			button.connect("pressed", turn_order.current_turn, "attack", [character])
			button.connect("pressed", self, "next_turn")
			temp_buttons.append(button)

func clear_temp_buttons():
	for button in temp_buttons:
		button.queue_free()
	temp_buttons.clear()

func next_turn():
	clear_temp_buttons()
	turn_order.go_to_next_turn()
	turn_order.current_turn.start_turn()
	self.status = Action.Attack
	force_apply_status()

func _check_gameover_condition():
	yield(get_tree(),"idle_frame")
	var size = get_tree().get_nodes_in_group("P1 Characters").size()
	print("P1: %d remaining" % size)
	if size == 0:
		if get_tree().get_nodes_in_group("P2 Characters").size() == 0 :
			print("DRAW!?")
			var timer = get_tree().create_timer(3)
			timer.connect("timeout", get_tree(), "reload_current_scene")
			return
		else:
			print("P2 Wins!!!")
			var timer = get_tree().create_timer(3)
			timer.connect("timeout", get_tree(), "reload_current_scene")
			return
	size = get_tree().get_nodes_in_group("P2 Characters").size()
	print("P2: %d remaining" % size)
	if size == 0:
		print("P1 Wins!!!")
		var timer = get_tree().create_timer(3)
		timer.connect("timeout", get_tree(), "reload_current_scene")
		return
