extends StaticBody2D

var up := false
var down := false
var right := false
var left:= false

var activeTexture := preload("res://SpriteSheets/Tilemaps/BreakBlock/ActiveWall.png")
var inactiveTexture := preload("res://SpriteSheets/Tilemaps/BreakBlock/InactiveWall.png")

func _ready():
	checkForWall(0)


func breakBlock():
	
	$RayCast2D.cast_to = Vector2(50, 0)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().has_method("checkForWall"):
			$RayCast2D.get_collider().checkForWall(4)
	
	$RayCast2D.cast_to = Vector2(-50, 0)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().has_method("checkForWall"):
			$RayCast2D.get_collider().checkForWall(3)
	
	$RayCast2D.cast_to = Vector2(0, 50)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().has_method("checkForWall"):
			$RayCast2D.get_collider().checkForWall(2)
	
	$RayCast2D.cast_to = Vector2(0, -50)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().has_method("checkForWall"):
			$RayCast2D.get_collider().checkForWall(1)
	
	queue_free()

func checkForWall(entry : int):
	# Sends a Raycast in cardinal directions and updates direction variables accordingly
	# Takes an int as a direction in which the signal is being called from
	# 0 = none
	# 1 = Up
	# 2 = Down
	# 3 = Right
	# 4 = Left
	
	print(entry)
	
	if entry != 3:
		$RayCast2D.cast_to = Vector2(50, 0)
		$RayCast2D.force_raycast_update()
		right = $RayCast2D.is_colliding()
	else:
		right = false
	
	if entry != 4:
		$RayCast2D.cast_to = Vector2(-50, 0)
		$RayCast2D.force_raycast_update()
		left = $RayCast2D.is_colliding()
	else:
		left = false
	
	if entry != 2:
		$RayCast2D.cast_to = Vector2(0, -50)
		$RayCast2D.force_raycast_update()
		up = $RayCast2D.is_colliding()
	else:
		up = false
	
	if entry != 1:
		$RayCast2D.cast_to = Vector2(0, 50)
		$RayCast2D.force_raycast_update()
		down = $RayCast2D.is_colliding()
	else:
		down = false
	
	updateSprite()

func updateSprite():
	# takes the current variables and updates the sprite sides. 
#	print(" START ======================")
#	print(up)
#	print(down)
#	print(right)
#	print(left)
#	print(" STOP ====================")
	
	if up:
		$UpWall.texture = inactiveTexture
	else:
		$UpWall.texture = activeTexture
	
	if down:
		$DownWall.texture = inactiveTexture
	else:
		$DownWall.texture = activeTexture
	
	if right:
		$RightWall.texture = inactiveTexture
	else:
		$RightWall.texture = activeTexture
		
	if left:
		$LeftWall.texture = inactiveTexture
	else:
		$LeftWall.texture = activeTexture
	
# Unused Code:
#func _on_BreakBlock_area_entered(area):
#	if area.is_in_group("Destroys_Objects"):
#		area.despawnBullet()
#		breakBlock()
