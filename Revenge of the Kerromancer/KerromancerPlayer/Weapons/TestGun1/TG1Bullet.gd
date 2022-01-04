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
		if dir < 0:
			$Graphic.flip_h = true
		else:
			$Graphic.flip_h = false
		velocity.x = SPEED * dir
		distance += velocity.x
		position += velocity
		
		if distance == 400 * dir:
			despawnBullet()
	
	elif axis == "Up":
		rotation_degrees = -90
		velocity.y = SPEED
		distance += velocity.y
		position -= velocity
		
		if distance == 400:
			despawnBullet()
	elif axis == "Down":
		rotation_degrees = 90
		velocity.y = SPEED 
		distance += velocity.y
		position += velocity
		
		if distance == 400:
			despawnBullet()

	
	


func _on_TG1Bullet_body_entered(body):
	despawnBullet()

func despawnBullet():
	set_physics_process(false)
	$Graphic.play("Despawn")


func _on_TG1Bullet_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.is_in_group("Enemy"):
		area.takeDamage(damage)
	if not area.is_in_group("Player_Projectile"):
		despawnBullet()


func _on_Graphic_animation_finished():
	if $Graphic.animation == "Despawn":
		queue_free()
		print("done")
