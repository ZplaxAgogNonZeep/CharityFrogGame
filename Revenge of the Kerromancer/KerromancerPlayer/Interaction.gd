extends Area2D

var activeArea = null

func interact():
	if activeArea != null:
		activeArea.activate()
	else:
		pass

func _on_Interaction_area_entered(area):
	activeArea = area


func _on_Interaction_area_exited(area):
	activeArea = null
