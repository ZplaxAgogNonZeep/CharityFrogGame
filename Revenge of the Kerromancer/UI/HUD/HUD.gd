extends Control

onready var empty = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")

onready var manaFull = preload("res://SpriteSheets/UI/Tadpole.png")
onready var manaEmpty = preload("res://SpriteSheets/UI/TadpoleEmpty.png")

var posnHist := 0

func getCursorCoordinates(posn : int) -> int: 
	match posn:
		0:
			return 64
		1:
			return 184
		2:
			return 304
		_:
			return 0

func updateHUD(player):
	# Takes a reference to the player node and directly takes the various variables from it to fill in the hud
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
			get_node("Mana" + str(count)).texture = null
			count += 1
	
	count = 0
	while count < value:
		get_node("Mana" + str(count)).texture = manaFull
		count += 1
	
	# Magic Slots
	# Sets up each spell in the correct slot
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
	
	# Gets the posn to the corret location and Tweens cursor in place
	var posn = player.getPrimaryPosn()
	
	if posn != posnHist:
		$MagicSelector/Tween.interpolate_property(
			$MagicSelector, 
			"position", 
			Vector2(getCursorCoordinates(posnHist), 56), 
			Vector2(getCursorCoordinates(posn), 56),
			.1,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT)
		
		if posn > posnHist:
			$MagicSelector/Tween.interpolate_property(
				$MagicSelector, 
				"rotation_degrees", 
				0, 
				90,
				.2,
				Tween.TRANS_LINEAR)
		else:
			$MagicSelector/Tween.interpolate_property(
				$MagicSelector, 
				"rotation_degrees", 
				0, 
				-90,
				.2,
				Tween.TRANS_LINEAR)
		
		$Cursor/Tween.interpolate_property(
			$Cursor, 
			"position", 
			Vector2(getCursorCoordinates(posnHist), 144), 
			Vector2(getCursorCoordinates(posn), 144),
			.1,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT)
		
		$MagicSelector/Tween.start()
		$Cursor/Tween.start()
	
	# Weapon
	
	# Finish
	
	posnHist = posn

