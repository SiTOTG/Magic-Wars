class_name BarUI
extends Control

func update_bar(value, max_value):
	if max_value <= 0 :
		max_value = 1
	value = clamp(value, 0, max_value)
	var rate = 1.0*value/max_value
	var tween = get_tree().create_tween()
	var before = $background/current.rect_size
	var end = Vector2(before)
	end.x = int(rate*$background.rect_size.x)
	tween.tween_property($background/current, "rect_size", end, 0.6)
