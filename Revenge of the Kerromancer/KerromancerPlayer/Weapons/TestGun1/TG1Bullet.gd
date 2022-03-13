extends Area2D

# Move Forward, stop on collision, or about end of screen.

var dir = 0
const SPEED = 10
var velocity = Vector2.ZERO

var axis = ""

var damage = 1
var distance = 0
var max_distance = 300

func _physics_process(_delta):
	if axis == "Horizontal":
		if dir < 0:
			$Graphic.flip_h = true
		else:
			$Graphic.flip_h = false
		velocity.x = SPEED * dir
		distance += velocity.x
		position += velocity
		
		if distance == max_distance * dir:
			despawnBullet(2)
	
	elif axis == "Up":
		rotation_degrees = -90
		velocity.y = SPEED
		distance += velocity.y
		position -= velocity
		
		if distance == max_distance:
			despawnBullet(2)
	elif axis == "Down":
		rotation_degrees = 90
		velocity.y = SPEED 
		distance += velocity.y
		position += velocity
		
		if distance == max_distance:
			despawnBullet(2)


func _on_TG1Bullet_body_entered(body):
	if body.is_in_group("Destructable"):
		body.breakBlock()
	despawnBullet(1)


#func _on_TG1Bullet_area_shape_entered(_area_id, area, _area_shape, _self_shape):
#	print("Bulllet")
#	if area != null:
#		if not area.is_in_group("Player_Projectile"):
#			despawnBullet()

func despawnBullet(despawnSource : int):
	# 0 = Enemy
	# 1 = Environment
	# 2 = Time Out
	set_physics_process(false)
	$Graphic.play("Despawn")

func _on_Graphic_animation_finished():
	if $Graphic.animation == "Despawn":
		queue_free()
