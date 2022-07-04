extends Node

# Takes Timer requests so that multiple Timers can be spawned

var timerQueue = []

func createTimer(node, time: float) -> int :
	# Takes a node reference and a number of seconds then creates a timer with that much time on it
	# and adds the timer node to a list where it can be accessed later with the returned int
	var timer = Timer.new()
	timer.connect("timeout", node, "_on_Timer_Timeout")
	timer.one_shot = true
	add_child(timer)
	timerQueue.append(get_children()[get_children().size() - 1])
	timer.start(time)
	return timerQueue.size() - 1

func clearTimer(queueNumber : int):
	# clears the node at the given index in timerQueue
	timerQueue[queueNumber].queue_free()
	
	#Printing code for testing, ignore
#	yield(get_tree(), "idle_frame")
#	print(get_children())
