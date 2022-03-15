extends Area2D

var damage = 4
var type = "FireBall"


func despawnBullet(despawnSource : int):
	# 0 = Enemy
	# 1 = Environment
	# 2 = Time Out
	find_parent("LevelBullets").removeBullet(type)
	get_parent().queue_free()
