extends "composite_node.gd"

func _ready():
	._ready()

func on_enter():
	current_child = 0
	children[0].on_enter()

func tick(delta):
	var status = children[current_child].tick(delta)

	if status == BT_SUCCESS:
		current_child += 1
		if current_child >= children.size():
			return exit(BTNodeClass.State.SUCCESS)

		children[current_child].on_enter()
		return BTNodeClass.State.RUNNING

	return exit(status)
