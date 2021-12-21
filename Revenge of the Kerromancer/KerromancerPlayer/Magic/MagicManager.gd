extends Node2D

var magicSlots = []

var primaryMagic = null

onready var kino = get_parent()

func _ready():
	magicSlots = get_children()
	if magicSlots != []:
		primaryMagic = magicSlots[0]

func onMagicPressed():
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
