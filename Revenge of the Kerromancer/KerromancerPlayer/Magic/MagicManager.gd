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
	if get_child_count() > 0:
		var count = 0
		while count < get_child_count():
			get_child(count).queue_free()
			count += 1
	
	var count = 0
	while count < magicInstances.size():
		add_child(magicInstances[count])
		count += 1

func addMagic(magicInstance):
	if get_child_count() < 3:
		add_child(magicInstance)
		magicSlots.append(magicInstance)
		primaryMagic = get_child(0)
	
