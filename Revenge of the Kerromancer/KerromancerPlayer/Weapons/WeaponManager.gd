extends Node2D

var activeWeapon

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}

enum SIDE {
	LEFT,
	RIGHT
}

var currentDirection
var currentSide

# This is an Unholy Abomination but damn does it do the job
# Haha not anymore

func onShootPressed():
	if activeWeapon != null:
		activeWeapon.shoot()


func setSide(side):
	if activeWeapon != null:
		activeWeapon.setSide(side)


func changeDirection(direction):
	if activeWeapon != null:
		activeWeapon.setDirection(direction)
	
func setWeapon(weaponInstance):
	if get_child_count() > 0:
		get_child(0).queue_free()
	activeWeapon = weaponInstance
	add_child(weaponInstance)
	get_parent().Kino_updateUI()
