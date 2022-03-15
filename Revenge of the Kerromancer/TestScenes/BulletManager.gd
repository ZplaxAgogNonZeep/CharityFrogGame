extends Node2D

var bulletDict := {}

func spawnBullet(spawnPosition, dir, direction, side, bulletInstance, bulletMAX):
	
	if bulletDict.get(bulletInstance.type, 0) < bulletMAX:
		bulletDict[bulletInstance.type] = bulletDict.get(bulletInstance.type, 0) + 1
		
		bulletInstance.position = spawnPosition
		bulletInstance.dir = dir
		bulletInstance.currentDirection = direction
		bulletInstance.currentSide = side
		add_child(bulletInstance)

func removeBullet(type):
	if bulletDict.get(type, 0) > 0:
		bulletDict[type] = bulletDict.get(type, 0) - 1


#var bullet_dict = {}
#func init_bullet(bullet_id: String, bullet_scene: PackedScene, init_args) -> Node:
#    # initialize pool for this bullet ID
#    if !bullet_dict.has(bullet_id):
#        bullet_dict[bullet_id] = []
#    var bullets: Array = bullet_dict[bullet_id]
#
#    # count active bullets in the pool
#    var num_active := 0
#    var max_active := 1
#    var inactive := []
#    for bullet in bullets:
#        # the bullet should have a variable indicating its limit
#        max_active = bullet.max_active
#        # this variable, a bool, is added to the bullet for the sake of pooling
#        if bullet.alive:
#            num_active += 1
#        else:
#            inactive.append(bullet)
#
#    # limit exceeded; don't create the bullet
#    if num_active >= max_active:
#        return null
#
#    # get an inactive bullet, if it exists, otherwise make a new one
#    var bullet = null
#    if inactive.size() == 0:
#        bullet = bullet_scene.instance()
#        bullets.append(bullet)
#    else:
#        bullet = inactive.pop_front()
#    assert(bullet != null)
#
#    # initialize the bullet
#    bullet.initialize(init_args)
#    return bullet
