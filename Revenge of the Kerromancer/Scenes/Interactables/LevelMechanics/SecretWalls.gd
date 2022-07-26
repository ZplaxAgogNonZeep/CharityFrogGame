extends TileMap

# TileMaps that dissapeare when the area is entered

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and not visible:
		visible = false
		get_tree().root.get_node("Game").triggerFlag(name)
