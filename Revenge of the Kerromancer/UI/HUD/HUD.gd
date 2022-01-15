extends Control

onready var empty = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")

func _ready():
	pass

func updateHUD(player):
	print(player.getMagicSlots())
	$HealthBar.max_value = player.MAX_health
	$HealthBar.value = player.health
	$HealthNumber.text = str(player.health)
	
	$ManaBar.max_value = player.MAX_mana
	$ManaBar.value = player.mana
	$ManaNumber.text = str(player.mana)
	
	if player.getMagicSlots() != []:
		print("In HUD: " + str(player.getMagicSlots()[0]))
		$Primary.texture = player.getMagicSlots()[0].icon
		
		if player.getMagicSlots().size() >= 2:
			$Secondary.texture = player.getMagicSlots()[1].icon
		else:
			$Secondary.texture = empty
		
		if player.getMagicSlots().size() >= 3:
			$Tertiary.texture = player.getMagicSlots()[2].icon
		else:
			$Tertiary.texture = empty
	else:
		$Primary.texture = empty
		$Secondary.texture = empty
		$Tertiary.texture = empty
	
