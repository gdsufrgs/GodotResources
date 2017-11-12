extends Node

signal used_up

export(int, 0)      var size
export(PackedScene) var scene
export(bool)        var autoload = true

var counter
var pool = []

func _ready():
	if autoload: load_pool()

func load_pool():
	clear_pool()
	counter = 0
	for i in range(size):
		pool.append(scene.instance())

func clear_pool():
	for item in pool:
		item.queue_free()
	pool.clear()

func get_item():
	var item = pool[counter]

	counter += 1
	if counter >= pool.size():
		counter = 0
		emit_signal("used_up")

	return item

func _exit_tree():
	clear_pool()
