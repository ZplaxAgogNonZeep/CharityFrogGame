extends Area2D

var activeArea = null

func interact():
	if activeArea != null:
		print("activating!")
		activeArea.activate()
	else:
		print("nothing there")

func _on_Interaction_area_entered(area):
	print(area.name)
	activeArea = area


func _on_Interaction_area_exited(area):
	activeArea = null
	print(activeArea)
