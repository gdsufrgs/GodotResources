extends "base_node.gd"

export var current_child = 0
var children = []

func _ready():
	var c = get_children()
	for child in c:
		if child is BTNodeClass:
			children.append(child)
