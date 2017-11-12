extends "decorator_node.gd"

export(int) var max_count = -1
var count setget set_count

func _ready():
	._ready()

func set_count(value):
	max_count = value

func on_enter():
	count = max_count
	child.on_enter()

func tick(delta):
	var status = child.tick(delta)

	if status != BTNodeClass.State.RUNNING:
		on_enter()

	if count < 0:
		return BTNodeClass.State.RUNNING

	count -= 1
	if count > 0:
		return BTNodeClass.State.RUNNING

	return exit(BTNodeClass.State.SUCCESS)
