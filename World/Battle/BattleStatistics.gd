class_name BattleStatistics
extends Object

var number_of_turns := ""

class PlayerStats:
	var winner: bool = true
	var character_stats := {}

	var damage_dealt_total setget set_damage_dealt_total, get_damage_dealt_total
	func set_damage_dealt_total(_value):
		printerr("Damage dealt is automatically calculated, and should not be setted")
	
	func get_damage_dealt_total():
		var total := 0
		for character_slot in character_stats:
			var char_stats = character_stats[character_slot] as CharacterStats
			total += char_stats.damage_dealt
		return total

	var damage_taken_total setget set_damage_taken_total, get_damage_taken_total
	func set_damage_taken_total(_value):
		printerr("Damage taken is automatically calculated, and should not be setted")
	
	func get_damage_taken_total():
		var total := 0
		for character_slot in character_stats:
			var char_stats = character_stats[character_slot] as CharacterStats
			total += char_stats.damage_taken
		return total

	var damage_healed_total setget set_damage_healed_total, get_damage_healed_total
	func set_damage_healed_total(_value):
		printerr("Damage healed is automatically calculated, and should not be setted")
	
	func get_damage_healed_total():
		var total := 0
		for character_slot in character_stats:
			var char_stats = character_stats[character_slot] as CharacterStats
			total += char_stats.damage_healed
		return total

class CharacterStats:
	var damage_dealt := 0
	var damage_taken := 0
	var damage_healed := 0
	var alive: bool = true

var players := {} # Player stats
