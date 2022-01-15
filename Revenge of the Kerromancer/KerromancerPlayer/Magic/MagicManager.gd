extends Node2D

var magicSlots = []

var primaryMagic = null

onready var kino = get_parent()

func _ready():
	magicSlots = get_children()
	if magicSlots != []:
		primaryMagic = magicSlots[0]

func onMagicPressed():
	if magicSlots != []:
		primaryMagic.useMagic(kino)

func left():
	if magicSlots != []:
		move_child(get_child(magicSlots.size() - 1), 0)
	
	magicSlots = get_children()
	if magicSlots != []:
		primaryMagic = get_child(0)
	
	kino.Kino_updateUI()

func right():
	if magicSlots != []:
		move_child(get_child(0), magicSlots.size() - 1)
	
	magicSlots = get_children()
	if magicSlots != []:
		primaryMagic = get_child(0)
	
	kino.Kino_updateUI()

func setMagic(magicInstances):
	
	print("Starting Player Routine ============")
	
	print("Child Count: " + str(get_child_count()))
	if get_child_count() > 0:
		var loopTime = get_child_count()
		var count = 0
		magicSlots = []
		while count < loopTime:
			print("COUNT IS AT: " + str(count))
			print("to be cleared: " + str(get_child(count)))
			if get_child(0) != null:
				get_child(0).free()
			count += 1
	
	print("after clearing " + str(get_children()))
	
	var count = 0
	while count < magicInstances.size():
		add_child(magicInstances[count])
		count += 1
	
	if get_child_count() > 0:
		primaryMagic = get_child(0)
		magicSlots = get_children()
		# GET CHILDREN IS THE ISSUE FIX IT
		print("In Children Are: " + str(get_children()))
		print("PLAYER DONE =====================")

func addMagic(magicInstance):
	if get_child_count() < 3:
		add_child(magicInstance)
		magicSlots.append(magicInstance)
		primaryMagic = get_child(0)
	
