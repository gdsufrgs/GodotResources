extends "composite_node.gd"

func _ready():
	._ready()

func on_enter():
	current_child = 0
	children[0].on_enter()

func tick(delta):
	var status = children[current_child].tick(delta)

	if status == BT_FAILURE:
		current_child += 1
		if current_child >= children.count():
			return exit(BTNodeClass.State.FAILURE)

		return BTNodeClass.State.RUNNING

	return exit(status)
