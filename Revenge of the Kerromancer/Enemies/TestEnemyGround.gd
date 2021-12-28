extends KinematicBody2D

var velocity = Vector2.ZERO
var dir = 1
var gravity = 1000

var health = 5
const MAX_Health = 5
const damage = 2

func _ready():
	pass

func _physics_process(_delta):
	
	if dir != getDir():
		dir = getDir()
	
	velocity.x = lerp(velocity.x, dir * 100, 0.056)
	
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)

func getDir():
	if velocity.x == 0:
		return dir * -1
	else:
		if $Right.is_colliding():
			return -1
		
		if $Left.is_colliding():
			return 1
		
		return dir

func takeDamage(dmg):
	health -= dmg
	
	get_tree().root.get_node("Game").callDamageNumber(dmg, position)
	
	if health <= 0:
		health = 0
		die()
	
	

func die():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.takeDamage(damage)


func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("Player_Projectile"):
		takeDamage(area.damage)
