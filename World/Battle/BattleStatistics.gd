class_name BattleStatistics
extends Object

var number_of_turns := ""

class PlayerStats:
	var winner: bool = true
	var character_stats := {}

class CharacterStats:
	var damage_dealt := 0
	var alive: bool = true

var players := {} # Player stats
