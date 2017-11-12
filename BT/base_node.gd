extends Node

enum State {
	FAILURE = 0,
	SUCCESS = 1,
	RUNNING = 2
}

var BTNodeClass = load("base_node.gd")
var root

func _ready():
	root = get_root()

func get_root():
	if root != null:
		return root

	if get_parent() is BTNodeClass:
		return get_parent().get_BTRoot()
	return self

func tick(delta):
	return State.SUCCESS

func on_enter():
	pass

func on_exit():
	pass

func exit(status):
	if status != State.RUNNING: on_exit()
	return status
