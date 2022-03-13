extends Node2D

var horizontalCollision := false
var verticalCollision := false


func _on_Left_body_entered(body):
	print("Left Enter")
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			print("It not worky")
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true


func _on_Right_body_entered(body):
	print("Right Enter")
	if body.is_in_group("Crushable"):
		if horizontalCollision:
			print("It not worky")
			get_parent().takeDamage(999, true)
		else:
			horizontalCollision = true

func _on_Top_body_entered(body):
	print("Top Enter, vert:" + str(verticalCollision))
	print(body.name)
	if body.is_in_group("Crushable"):
		if verticalCollision:
			print("It worky")
			get_parent().takeDamage(999, true)
		else:
			print("vert is false")
			verticalCollision = true

func _on_Bottom_body_entered(body):
	print("Bottom Enter, vert:" + str(verticalCollision))
	print(body.name)
	if body.is_in_group("Crushable"):
		if verticalCollision:
			print("It worky")
			get_parent().takeDamage(999, true)
		else:
			print("vert is false")
			verticalCollision = true



func _on_Left_body_exited(_body):
	print("Left Exit")
	horizontalCollision = false


func _on_Right_body_exited(_body):
	print("Right Exit")
	horizontalCollision = false


func _on_Top_body_exited(_body):
	print("Top Exit")
	verticalCollision = false


func _on_Bottom_body_exited(_body):
	print("Bottom Exit")
	verticalCollision = false
