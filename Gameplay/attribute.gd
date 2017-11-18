extends Node

signal changed_value
signal changed_max

export(float) var base  = 100.0 setget set_base
export(float) var max_base  = 100.0

export(float) var bonus = 0.0 setget set_bonus
export(float) var mult  = 1.0 setget set_mult
export(float) var max_value = 200.0 setget set_maxvalue

var value = 0.0 setget , get_value

func _ready():
	print(str(base))

func set_maxvalue(v):
	var prev = get_value()

	var prev_max = max_value
	max_value = max(0, v)
	if max_value != prev_max:
		emit_signal("changed_max")

		value = get_value()
		if value != prev:
			emit_signal("changed_value")

func set_base(v):
	var prev = base
	base = clamp(v, 0, max_base)
	if base != prev:
		emit_signal("changed_value")

func set_bonus(v):
	var prev = get_value()
	bonus = max(0, v)
	if prev != get_value():
		emit_signal("changed_value")

func set_mult(v):
	var prev = get_value()
	mult = max(0, v)
	if prev != get_value():
		emit_signal("changed_value")

func get_value():
	value = clamp(base * mult + bonus, 0, max_value)
	return value

