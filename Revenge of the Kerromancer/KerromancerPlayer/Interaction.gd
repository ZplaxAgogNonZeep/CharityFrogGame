extends Area2D

var activeArea = null

func interact():
	if activeArea != null:
		activeArea.activate()
	else:
		pass

func _on_Interaction_area_entered(area):
	if area.is_in_group("Interactable"):
		activeArea = area


func _on_Interaction_area_exited(area):
	if area.is_in_group("Interactable"):
		activeArea = null
