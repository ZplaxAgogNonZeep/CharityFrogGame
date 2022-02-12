extends KinematicBody2D

var velocity = Vector2.ZERO
var dir = 1

onready var start = $Start.global_position
onready var end = $End.global_position
var speed = 4

var health = 2
const MAX_Health = 2
const damage = 1

var forward = true

#func _physics_process(_delta):
#	if horizontal:
#		if dir != getDir():
#			dir = getDir()
#			print(getDir())
#		velocity.x = lerp(velocity.x, dir * 100, 0.056)
#		velocity.y = 0
#		velocity = move_and_slide(velocity, Vector2.ZERO)
#	else:
#		if dir != getDir():
#			dir = getDir()
#		velocity.y = lerp(velocity.y, dir * 100, 0.056)
#		velocity.x = 0
#		velocity = move_and_slide(velocity, Vector2.ZERO)

#func getDir():
#	if horizontal:
#		if velocity.x == 0:
#			return dir * -1
#	elif !horizontal:
#		if velocity.y == 0:
#			return dir *-1
#	if horizontal:
#		$RightDown.cast_to = Vector2(64, 0)
#		$LeftUp.cast_to = Vector2(-64, 0)
#	else:
#		$RightDown.cast_to = Vector2(0, 64)
#		$LeftUp.cast_to = Vector2(0, -64)
#
#	if $RightDown.is_colliding():
#		return -1
#	if $LeftUp.is_colliding():
#		return 1
#
#	return dir

func _ready():
	forward = true
	$Tween.interpolate_property(self, "position", start, end, speed, Tween.TRANS_SINE)
	$Tween.start()



func takeDamage(dmg):
	health -= dmg
	get_tree().root.get_node("Game").callDamageNumber(dmg, position)
	if health <= 0:
		health = 0
		die()

func die():
	queue_free()


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.takeDamage(damage)


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_Projectile"):
		takeDamage(area.damage)
		area.despawnBullet(0)


func _on_Tween_tween_all_completed():
	forward = !forward
	if forward:
		$Tween.interpolate_property(self, "position", start, end, speed, Tween.TRANS_SINE)
	else:
		$Tween.interpolate_property(self, "position", end, start, speed, Tween.TRANS_SINE)
	$Tween.start()
