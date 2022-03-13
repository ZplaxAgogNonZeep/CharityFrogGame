extends KinematicBody2D

var velocity = Vector2.ZERO
var dir = 1
var gravity = 1000

var health = 5
const MAX_Health = 5
const damage = 2

var playerInRange
var playerBody

func _ready():
	pass

func _physics_process(_delta):
	if playerInRange:
		damagePlayer(playerBody)
	

	if dir != getDir():
		scale.x *= -1
		dir = getDir()
	
	velocity.x = lerp(velocity.x, dir * 100, 0.056)
	
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)

func getDir():
	if velocity.x == 0:
		return dir * -1
	else:
		return dir

func takeDamage(dmg):
	health -= dmg
	get_tree().root.get_node("Game").callDamageNumber(dmg, position)
	if health <= 0:
		health = 0
		die()

func die():
	queue_free()

func damagePlayer(body):
	body.takeDamage(damage)

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_Projectile"):
		takeDamage(area.damage)
		area.despawnBullet(0)

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		playerInRange = true
		playerBody = body
		damagePlayer(body)

func _on_Hitbox_body_exited(body):
	if body.is_in_group("Player"):
		playerInRange = false
