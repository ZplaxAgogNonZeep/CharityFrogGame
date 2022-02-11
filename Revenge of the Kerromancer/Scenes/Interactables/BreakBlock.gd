extends StaticBody2D




#func _on_BreakBlock_area_entered(area):
#	if area.is_in_group("Destroys_Objects"):
#		area.despawnBullet()
#		breakBlock()

func breakBlock():
	queue_free()
