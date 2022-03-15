extends Node2D

var horizontalCollision := false
var verticalCollision := false


func _on_Left_body_entered(body):
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true


func _on_Right_body_entered(body):
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true

func _on_Top_body_entered(body):
	if body.is_in_group("Crushable"):
		if verticalCollision:
			get_parent().takeDamage(999, true)
		else:
			verticalCollision = true

func _on_Bottom_body_entered(body):
	if body.is_in_group("Crushable"):
		if verticalCollision:
			get_parent().takeDamage(999, true)
		else:
			verticalCollision = true



func _on_Left_body_exited(_body):
	horizontalCollision = false


func _on_Right_body_exited(_body):
	horizontalCollision = false


func _on_Top_body_exited(_body):
	verticalCollision = false


func _on_Bottom_body_exited(_body):
	verticalCollision = false
