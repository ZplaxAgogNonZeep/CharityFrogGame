extends Node2D

var activeWeapon

var directionName = ""

# This is an Unholy Abomination but damn does it do the job

func onShootPressed():
	if activeWeapon != null:
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
	if activeWeapon != null:
		if(isLeft):
			activeWeapon.position.x = 6
			if directionName == "Down":
				activeWeapon.rotation_degrees = -90
			elif directionName == "Up":
				activeWeapon.rotation_degrees = 90
		else:
			activeWeapon.position.x = -6
			if directionName == "Down":
				activeWeapon.rotation_degrees = 90
			elif directionName == "Up":
				activeWeapon.rotation_degrees = -90
		
		activeWeapon.sprite.flip_h = isLeft


func changeDirection(direction):
	if activeWeapon != null:
		if direction == "Up":
			if activeWeapon.sprite.flip_h:
				activeWeapon.rotation_degrees = 90
			else:
				activeWeapon.rotation_degrees = -90
			directionName = "Up"
			
		elif direction == "Down":
			if activeWeapon.sprite.flip_h:
				activeWeapon.rotation_degrees = -90
			else:
				activeWeapon.rotation_degrees = 90
			directionName = "Down"
			
		elif direction == "Forward":
			activeWeapon.rotation_degrees = 0
			directionName = "Forward"
	
func setWeapon(weaponInstance):
	if get_child_count() > 0:
		get_child(0).queue_free()
	activeWeapon = weaponInstance
	add_child(weaponInstance)
	get_parent().Kino_updateUI()
