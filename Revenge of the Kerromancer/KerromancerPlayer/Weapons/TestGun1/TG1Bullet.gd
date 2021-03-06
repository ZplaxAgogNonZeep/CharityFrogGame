extends Area2D

# Move Forward, stop on collision, or about end of screen.

var type := "TG1"

var dir = 0
const SPEED = 10
var velocity = Vector2.ZERO

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}

enum SIDE {
	LEFT,
	RIGHT
}


var currentDirection = DIRECTION.FORWARD
var currentSide = SIDE.RIGHT

var damage = 1
var distance = 0
var max_distance = 300



func _ready():
	match currentDirection:
		DIRECTION.FORWARD:
			if dir < 0:
				$Graphic.flip_h = true
			else:
				$Graphic.flip_h = false
		DIRECTION.UP:
			rotation_degrees = -90
		DIRECTION.DOWN:
			rotation_degrees = 90
		_:
			pass

func _physics_process(_delta):
	match currentDirection:
		DIRECTION.FORWARD:
			velocity.x = SPEED * dir
			distance += velocity.x
			global_position += velocity

			if distance == max_distance * dir:
				despawnBullet(2)
		DIRECTION.UP:

			velocity.y = SPEED
			distance += velocity.y
			global_position -= velocity

			if distance == max_distance:
				despawnBullet(2)
		DIRECTION.DOWN:

			velocity.y = SPEED 
			distance += velocity.y
			global_position += velocity

			if distance == max_distance:
				despawnBullet(2)
		_:
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
	get_parent().removeBullet(type)
	queue_free()
