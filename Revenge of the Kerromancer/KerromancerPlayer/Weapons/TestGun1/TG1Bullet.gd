extends Area2D

# Move Forward, stop on collision, or about end of screen.

var dir = 0
const SPEED = 10
var velocity = Vector2.ZERO

var axis = ""

var damage = 1
var distance = 0

func _physics_process(delta):
	if axis == "Horizontal":
		velocity.x = SPEED * dir
		distance += velocity.x
		position += velocity
		
		if distance == 400 * dir:
			despawnBullet()
	
	elif axis == "Up":
		velocity.y = SPEED
		distance += velocity.y
		position -= velocity
		
		if distance == 400:
			despawnBullet()
	elif axis == "Down":
		velocity.y = SPEED 
		distance += velocity.y
		position += velocity
		
		if distance == 400:
			despawnBullet()

	
	


func _on_TG1Bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.takeDamage(1)
	despawnBullet()

func despawnBullet():
	queue_free()
