extends Node2D

var horizontalCollision := false
var verticalCollision := false


func _on_Left_body_entered(body):
	print("Left")
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true


func _on_Right_body_entered(body):
	print("Right")
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true

func _on_Top_body_entered(body):
	print("Top")
	if body.is_in_group("Crushable"):
		if verticalCollision:
			get_parent().takeDamage(999, true)
		else:
			verticalCollision = true

func _on_Bottom_body_entered(body):
	print("Bottom")
	if body.is_in_group("Crushable"):
		if verticalCollision:
			get_parent().takeDamage(999, true)
		else:
			verticalCollision = true



func _on_Left_body_exited(body):
	horizontalCollision = false


func _on_Right_body_exited(body):
	horizontalCollision = false


func _on_Top_body_exited(body):
	verticalCollision = false


func _on_Bottom_body_exited(body):
	verticalCollision = false
