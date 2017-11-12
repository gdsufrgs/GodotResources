extends "decorator_node.gd"

func _ready():
	._ready()

func on_enter():
	child.on_enter()

func tick(delta):
	if child.tick(delta) == BTNodeClass.State.RUNNING:
		return BTNodeClass.State.RUNNING

	return exit(BTNodeClass.State.SUCCEED)
