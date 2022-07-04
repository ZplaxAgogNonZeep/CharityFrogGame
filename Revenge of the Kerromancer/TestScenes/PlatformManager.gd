extends Node2D

var platform = preload("res://Scenes/Interactables/LevelMechanics/FallingPlat.tscn")
var platIndex = []
var timeQueue = []
export var delay = 5

func _ready():
	for i in range(get_child_count()):
		platIndex.append(get_child(i).position)
		get_child(i).platPosn = i

func respawn(posn):
# Takes an Index Int and spawns a platform at that position (continued in timeout)
	var timerReturn = get_parent().get_parent().get_node("TimerCollection").createTimer(self, delay)
	timeQueue.append([posn, timerReturn])


func _on_Timer_Timeout():
#	print("Timeout Respawning")
	var spawned = platform.instance()
	spawned.position = platIndex[timeQueue[0][0]]
	get_parent().get_parent().get_node("TimerCollection").clearTimer(timeQueue[0][1])
	timeQueue.remove(0)
	add_child(spawned)
