extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

var active = false

func startState():
	kino.resetRaycast()
	sm.midAir = false
	active = true
	sm.setAnimation("Idle")
	$Timer.start(3)

func endState():
	active = false
	$Timer.stop()

func physics_process(_delta):
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
	
	kino.velocity.x = 0

func PlayerInRange():
	sm.setAnimation("Alert")

func _on_View_body_entered(body):
	if active and kino.isPlayerVisible(body.position):
		PlayerInRange()

func _on_Timer_timeout():
	if active:
		sm.flipSprite()
		$Timer.start(3)


func _on_Graphic_animation_finished():
	if kino.get_node("Graphic").animation == "Alert":
		kino.position += Vector2(0, -1)
		sm.changeState("Jump")
