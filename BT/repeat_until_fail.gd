extends "decorator_node"

var once = false

func _ready():
	._ready()

func on_enter():
	child.on_enter()

func tick(delta):
	var status = child.tick(delta)

	if status == BTStatus.SUCCESS:
		once = true
		on_enter()
		return BTStatus.RUNNING

	if once:
		return exit(BTStatus.SUCCESS)

	return exit(BTStatus.FAILURE)