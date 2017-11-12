extends "base_node.gd"

var child

func _ready():
	if get_child(0) is BTNodeClass:
		child = get_child(0)
