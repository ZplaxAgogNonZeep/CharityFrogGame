extends Control


func _ready():
	pass

func updateHUD(player):
	$HealthBar.max_value = player.MAX_health
	$HealthBar.value = player.health
	$HealthNumber.text = str(player.health)
	
	$ManaBar.max_value = player.MAX_mana
	$ManaBar.value = player.mana
	$ManaNumber.text = str(player.mana)
	
	if player.getMagicSlots() != []:
		$Primary.texture = player.getMagicSlots()[0].icon
		
		if player.getMagicSlots().size() >= 2:
			$Secondary.texture = player.getMagicSlots()[1].icon
		
		if player.getMagicSlots().size() >= 3:
			$Tertiary.texture = player.getMagicSlots()[2].icon
	
