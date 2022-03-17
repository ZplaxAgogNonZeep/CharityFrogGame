extends Control

onready var empty = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")

onready var manaFull = preload("res://SpriteSheets/UI/Tadpole.png")
onready var manaEmpty = preload("res://SpriteSheets/UI/TadpoleEmpty.png")

func _ready():
	pass

func updateHUD(player):
	$HealthBar.max_value = player.MAX_health
	$HealthBar.value = player.health
	$HealthNumber.text = str(player.health)
	
	# MANA STUFFS
	
	var value = player.mana
	var MAX_mana = player.MAX_mana
	
	var count = 0
	while count < MAX_mana:
		get_node("Mana" + str(count)).texture = manaEmpty
		count += 1
	
	if MAX_mana < 10:
		while count < 10:
			print(count)
			get_node("Mana" + str(count)).texture = null
			count += 1
	
	count = 0
	while count < value:
		get_node("Mana" + str(count)).texture = manaFull
		count += 1
	
	# END MANA
	
	
	if player.getMagicSlots() != []:
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
	
