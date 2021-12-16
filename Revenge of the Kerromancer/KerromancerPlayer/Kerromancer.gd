extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

onready var sprite = get_node("AnimatedSprite")

var velocity = Vector2.ZERO

var isJumping = false


func get_input():
	var dir = 0
	if Input.is_action_pressed("Right"):
		dir += 1
		sprite.flip_h = false
	if Input.is_action_pressed("Left"):
		dir -= 1
		sprite.flip_h = true
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = -600 #jump_speed
			isJumping = true
	
	if Input.is_action_just_released("Jump") and isJumping and velocity.y < 0:
		velocity.y = -200
		isJumping = false
