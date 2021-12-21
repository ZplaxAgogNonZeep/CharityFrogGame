extends KinematicBody2D

var velocity = Vector2.ZERO

var dir = 1

var gravity = 1000

func _ready():
	pass

func _physics_process(_delta):
	
	if dir != getDir():
		dir = getDir()
	
	print(dir)
	
	velocity.x = lerp(velocity.x, dir * 100, 0.056)
	
	velocity.y += gravity * _delta
	velocity = move_and_slide(velocity, Vector2.UP)

func getDir():
	if $Right.is_colliding():
		return -1
	
	if $Left.is_colliding():
		return 1
	
	return dir
