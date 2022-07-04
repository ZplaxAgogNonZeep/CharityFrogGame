extends Node2D

var playerBody
export var delay := 1.0
var speed := 200
var platPosn := 0
var isFalling := false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if playerBody.is_on_floor():
		$Timer.start(delay)
		set_physics_process(false)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and not isFalling:
		isFalling = true
		playerBody = body
		set_physics_process(true)

func _on_Timer_timeout():
	startFall()

func startFall():
	var distance = ($FallPoint.position.y - position.y) / speed
	print(distance)
	$Tween.interpolate_property(self, "position", position, $FallPoint.global_position, distance)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	get_parent().respawn(platPosn)
	queue_free()
