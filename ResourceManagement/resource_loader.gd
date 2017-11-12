extends Node

signal finished(path)

var thread    # thread to load resources
var mutex     # solves concurrency accessing variables
var semaphore # blocks the thread if no resource is pending

var queue = []   # list of interactive loaders queued
var pending = {} # set of pending requests, from 'path' to loader and resource

func _ready():
	start()

func start():
	if thread != null: return

	mutex = Mutex.new()
	semaphore = Semaphore.new()
	thread = Thread.new()
	thread.start(self, "thread_func")

func thread_func(u):
	while true:
		thread_process()

func thread_process():
	semaphore.wait()

	mutex.lock()
	while queue.size() > 0:

		var loader = queue[0]
		mutex.unlock()

		var ret = loader.poll()

		mutex.lock()
		if ret == ERR_FILE_EOF:
			var path = loader.get_meta("path")
			if path in pending:
				pending[path].Resource = loader.get_resource()
				pending[path].Loader = null
			queue.erase(loader)
			emit_signal("finished", path)

		elif ret != OK: # error
			printerr("Failed to get resource: " + loader.get_meta("path"))
			queue.erase(loader)

	mutex.unlock()

func queue_resource(path, priority = false):
	mutex.lock()

	if path in pending: # resource is already queued for loading
		mutex.unlock()
		return

	if ResourceLoader.has(path): # resource is already loaded
		pending[path] = {
			"Loader"   : null,
			"Resource" : ResourceLoader.load(path)
		}

		mutex.unlock()
		return

	var loader = ResourceLoader.load_interactive(path)
	loader.set_meta("path", path)

	if priority: queue.push_front(loader)
	else:        queue.push_back(loader)

	pending[path] = {
		"Loader"   : loader,
		"Resource" : null
	}

	semaphore.post()
	mutex.unlock()

func cancel_resource(path):
	mutex.lock()

	if path in pending and pending[path].Loader:
		queue.erase(pending[path].Loader)
		pending.erase(path)

	mutex.unlock()

func get_progress(path):
	mutex.lock()

	var progress = 0.0
	if path in pending:
		if pending[path].Loader:
			progress = float(pending[path].Loader.get_stage()) \
				   / float(pending[path].Loader.get_stage_count()) # line break
		else:
			progress = 1.0

	mutex.unlock()
	return progress

func get_progress_string(path):
	mutex.lock()

	var progress = ""
	if path in pending:
		if pending[path].Loader:
			progress += str(pending[path].Loader.get_stage()) + " / "
			progress += str(pending[path].Loader.get_stage_count())

	mutex.unlock()
	return progress

func is_ready(path):
	mutex.lock()

	var ready = false
	if path in pending: # if it has a loader, it's not ready
		ready = not pending[path].Loader

	mutex.unlock()
	return ready

func get_resource(path):
	mutex.lock()

	if not path in pending: # resource wasn't queued
		mutex.unlock()
		return ResourceLoader.load(path)

	if path in pending:
		if pending[path].Loader:
			pending[path].Loader.wait()
			pending[path].Resource = pending[path].Loader.get_resource()

	var resource = pending[path].Resource

	queue.erase(pending[path].Loader)
	pending.erase(path)
	mutex.unlock()

	return resource
