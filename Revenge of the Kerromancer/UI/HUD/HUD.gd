extends Control


func _ready():
	pass

func updateHUD(player):
	$HealthBar.max_value = player.MAX_health
	$HealthBar.value = player.health
	$HealthNumber.text = str(player.health)
