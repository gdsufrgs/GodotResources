extends "decorator_node.gd"

func on_enter():
	child.on_enter()

func tick(delta):
	var status = child.tick(delta)
	if status == BTNodeClass.State.RUNNING:
		return BT_RUNNING
	if status == BT_FAILURE:
		return exit(BTNodeClass.State.SUCCESS)
	if status == BT_SUCCESS:
		return exit(BTNodeClass.State.FAILURE)
