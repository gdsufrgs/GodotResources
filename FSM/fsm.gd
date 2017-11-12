extends Node

signal state_changed(from, to)

const StateClass = preload('state.gd')

var current          # name of the current state
var states = {}      # stored as (name -> node)
var transitions = {} # stored as (current -> (key -> next))

func _ready():
	for node in get_children():
		if node is StateClass:
			add_state(node)
			if current == null or current == "":
				current = node.get_name()

func add_state(node):
	states[node.get_name()] = node

func add_transition(from, to, key):
	if not transitions.has(from):
		transitions[from] = {}
	transitions[from][key] = to

func make_transition(key):
	if not transitions[current].has(key):
		return false

	var previous = current
	var next = transitions[current][key]
	if states[current].can_exit() and states[next].can_enter():
		states[current].exit()
		current = next
		states[next].enter()

		emit_signal("state_changed", previous, current)
		return true
	return false

func get_current():
	return states[current]
