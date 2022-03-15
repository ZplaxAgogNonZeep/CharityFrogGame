extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -650
export (int) var gravity = 1000
var dir = 0

var velocity = Vector2.ZERO

var type = "FireBall"

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

var currentJumps := 0
var MAX_Jumps := 4

func _ready():
	add_collision_exception_with(find_parent("LevelBullets").get_parent().get_node("PlayerManager").get_child(0))


func _physics_process(_delta):
	velocity.x = speed * dir
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		currentJumps += 1
		if currentJumps >= MAX_Jumps:
			$Hitbox.despawnBullet(2)
		else:
			velocity.y -= 300
	
	if is_on_wall():
		dir *= -1


