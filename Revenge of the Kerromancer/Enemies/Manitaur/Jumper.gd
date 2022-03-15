extends KinematicBody2D

var velocity := Vector2.ZERO
var health := 5
var damage := 2

var playerInRange : bool

func takeDamage(dmg):
	health -= dmg
	get_tree().root.get_node("Game").callDamageNumber(dmg, position)
	if health <= 0:
		health = 0
		die()
	if $StateMachine.stateName == "Idle":
		$StateMachine/Idle.PlayerInRange()

func die():
	queue_free()

func damagePlayer(body):
	body.takeDamage(damage)

func isPlayerVisible(playerPosn):
	if (position.x - playerPosn.x) < 0:
		$RayCast2D.cast_to = Vector2((position.x - playerPosn.x), -1 * (position.y - playerPosn.y))
	else:
		$RayCast2D.cast_to = Vector2((position.x - playerPosn.x) * -1, -1 * (position.y - playerPosn.y))
	
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("Player"):
			return true
	return false

func resetRaycast():
	$RayCast2D.cast_to = Vector2(-300, 0)
	yield(get_tree(), "idle_frame")
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():

		if $RayCast2D.get_collider().is_in_group("Player"):
			get_node("StateMachine/Idle").PlayerInRange()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_Projectile"):

		takeDamage(area.damage)
		area.despawnBullet(0)

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		playerInRange = true
		damagePlayer(body)

func _on_Hitbox_body_exited(body):
	if body.is_in_group("Player"):
		playerInRange = false
		
