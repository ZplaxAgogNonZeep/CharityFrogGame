extends Node2D

onready var activeWeapon = get_child(0)

func onShootPressed():
	if activeWeapon.rotation_degrees == 0:
		activeWeapon.shoot("Horizontal")
	elif activeWeapon.sprite.flip_h:
		if activeWeapon.rotation_degrees > 0:
			activeWeapon.shoot("Up")
		if activeWeapon.rotation_degrees < 0:
			activeWeapon.shoot("Down")
	elif not activeWeapon.sprite.flip_h:
		if activeWeapon.rotation_degrees > 0:
			activeWeapon.shoot("Down")
		if activeWeapon.rotation_degrees < 0:
			activeWeapon.shoot("Up")
	

func setSide(isLeft):
	if(isLeft):
		activeWeapon.position.x = 6
	else:
		activeWeapon.position.x = -6
	
	activeWeapon.sprite.flip_h = isLeft

func changeDirection(direction):
	if direction == "Up":
		if activeWeapon.sprite.flip_h:
			activeWeapon.rotation_degrees = 90
		else:
			activeWeapon.rotation_degrees = -90
	elif direction == "Down":
		if activeWeapon.sprite.flip_h:
			activeWeapon.rotation_degrees = -90
		else:
			activeWeapon.rotation_degrees = 90
	elif direction == "Forward":
		activeWeapon.rotation_degrees = 0
	

