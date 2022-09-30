extends HBoxContainer

const MIN_VOLUME = -50
const MAX_VOLUME = 6

onready var bus_name = $Name.text
onready var bus_index = AudioServer.get_bus_index(bus_name)
onready var value = $Value

func _ready():
	value.min_value = MIN_VOLUME
	value.max_value = MAX_VOLUME
	value.value = AudioServer.get_bus_volume_db(bus_index)

func _on_Value_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, value)
