class_name Player
extends Resource

export (Array, Resource) var characters = []
export (String, "P1 Characters", "P2 Characters") var player_group = "P1 Characters" 

# Battle
export (Array, Resource) var item_slots = []
export (Array, Resource) var selected_characters = []
export (int, 20, 100) var buy_points = 50
