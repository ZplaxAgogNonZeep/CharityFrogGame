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

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_Projectile"):
		print("enemy took damage")
		takeDamage(area.damage)
		area.despawnBullet(0)

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		playerInRange = true
		damagePlayer(body)

func _on_Hitbox_body_exited(body):
	if body.is_in_group("Player"):
		playerInRange = false
		
