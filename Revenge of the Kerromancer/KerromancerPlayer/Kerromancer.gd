extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var momentum = 0
const MAX_MOMENTUM = 300

onready var sprite = $Graphic

var velocity = Vector2.ZERO



#func get_input():
#	var dir = 0
#	if Input.is_action_pressed("Right"):
#		dir += 1
#		sprite.flip_h = false
#
#		if !isFalling:
#			if momentum < MAX_MOMENTUM:
#				momentum += 15
#
#		if is_on_floor():
#			setAnimation("Walk")
#	if Input.is_action_pressed("Left"):
#		dir -= 1
#		sprite.flip_h = true
#		if !isFalling:
#			if momentum < MAX_MOMENTUM:
#				momentum += 15
#		if is_on_floor():
#			setAnimation("Walk")
#
#	if dir != 0:
#		velocity.x = lerp(velocity.x, dir * speed, acceleration)
#	else:
#		#velocity.x = lerp(velocity.x, 0, friction)
#		if is_on_floor():
#			velocity.x = lerp(velocity.x, 0, friction)
#			setAnimation("Idle")
#		else:
#			if isFalling:
#				if sprite.flip_h:
#					dir = -1
#				else:
#					dir = 1
#				velocity.x = lerp(velocity.x, momentum * dir, friction)
#				print(momentum)
#
#func setAnimation(anim):
#	if sprite.animation != anim:
#		if sprite.frames.has_animation(anim):
#			sprite.play(anim)
#		else:
#			sprite.play()
#
#func _physics_process(delta):
#	if is_on_floor():
#		isFalling = false
#		momentum = 0
#
#	get_input()
#	velocity.y += gravity * delta
#	velocity = move_and_slide(velocity, Vector2.UP)
#
#	# Jump Starts
#	if Input.is_action_just_pressed("Jump"):
#		if is_on_floor():
#			velocity.y = -600 #jump_speed
#			isJumping = true
#
#
#
#	#Jump Arcs
#	if Input.is_action_just_released("Jump") and isJumping and velocity.y < 0:
#		velocity.y = -200
#		isJumping = false
#		isFalling = true
#
