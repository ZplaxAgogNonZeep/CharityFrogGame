extends Node2D



func _ready():
	pass

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}
enum SIDE {
	LEFT,
	RIGHT
}


func _on_Hitbox_body_entered(body):
	$RayCast2D.force_raycast_update()
	#yield(get_tree(), "idle_frame")
	if $RayCast2D.is_colliding():
		print("Hitbox entered and raycast set")
		get_parent().get_parent().get_node("LevelBullets").spawnBullet(
			$SpawnPoint.global_position, 
			scale.x, 
			DIRECTION.FORWARD, 
			SIDE.RIGHT, 
			load("res://KerromancerPlayer/Weapons/TestGun1/TurretBullet.tscn").instance(), 
			2)
