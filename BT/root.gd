extends "repeater.gd"

export(NodePath) var character_path = @".."
onready var character = get_node(character_path)

func _ready():
	root = self

	var BTNodeClass = preload("base_node.gd")
	if get_child(0) is BTNodeClass:
		child = get_child(0)

	set_process(true)
	on_enter()

func _process(delta):
	tick(delta)

func get_character():
	return character
