extends Area2D

var activeArea = null

func interact():
	if activeArea != null:
		if activeArea.has_method("activate"):
			activeArea.activate()
		else:
			activeArea.get_parent().activate()
	else:
		pass

func _on_Interaction_area_entered(area):
	if area.is_in_group("Interactable"):
		activeArea = area
	
	print(activeArea)

func _on_Interaction_area_exited(area):
	print("Object exited")
	if area.is_in_group("Interactable"):
		activeArea = null
