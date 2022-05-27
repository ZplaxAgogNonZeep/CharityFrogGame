extends Node2D

var magicSlots = []
var primaryPosn = 0
var primaryMagic = null

onready var kino = get_parent()

# BE VERY CAREFUL EDITING THIS
# This script causes a LOT of errors when busted

func _ready():
	magicSlots = get_children()
	if magicSlots != []:
		primaryMagic = magicSlots[0]

func onMagicPressed():
	# Activates the currently selected spell.
	if magicSlots != []:
		primaryMagic.useMagic(kino)

func left():
	# Rotates the selected spell to the left, putting it down in the posn list
	if magicSlots.size() > 0:
		primaryPosn -= 1
		if primaryPosn < 0:
			primaryPosn = magicSlots.size() - 1
		
		primaryMagic = magicSlots[primaryPosn]
		kino.Kino_updateUI()
#	if magicSlots != []:
#		move_child(get_child(magicSlots.size() - 1), 0)
#
#	magicSlots = get_children()
#	if magicSlots != []:
#		primaryMagic = get_child(0)

func right():
	# Rotates the selected spell to the right, putting it up in the posn list
	if magicSlots.size() > 0:
		primaryPosn += 1
		if primaryPosn > magicSlots.size() - 1:
			primaryPosn = 0
		
		primaryMagic = magicSlots[primaryPosn]
		kino.Kino_updateUI()
		print(primaryPosn)
#	if magicSlots != []:
#		move_child(get_child(0), magicSlots.size() - 1)
#
#	magicSlots = get_children()
#	if magicSlots != []:
#		primaryMagic = get_child(0)

func setMagic(magicInstances):
	if get_child_count() > 0:
		var loopTime = get_child_count()
		var count = 0
		magicSlots = []
		while count < loopTime:
			if get_child(0) != null:
				get_child(0).free()
			count += 1
	
	var count = 0
	while count < magicInstances.size():
		add_child(magicInstances[count])
		count += 1
	
	if get_child_count() > 0:
		primaryMagic = get_child(primaryPosn)
		magicSlots = get_children()

func addMagic(magicInstance):
	if get_child_count() < 3:
		add_child(magicInstance)
		magicSlots.append(magicInstance)
	
