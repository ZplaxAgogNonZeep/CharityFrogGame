extends Sprite

var active := false

func _ready():
	pass

func power(outlet : String, liveStatus : bool):
	# The primary signal that is called when passing power to an electric object
	setActive(liveStatus)
	var areas
	if outlet == "OutletA":
		areas = $OutletA.get_overlapping_areas()
	else:
		areas = $OutletB.get_overlapping_areas()
	
	#print("====================Power called in rail " + get_parent().name + " with availible areas: " + str(areas) + " searching for " + outlet)
	
	for i in range(areas.size()):
		#print("Checking line " + areas[i].get_parent().get_parent().name)
		if areas[i].get_parent().active != liveStatus:
			#print("Power in rail " + get_parent().name + " moving on to " + areas[i].get_parent().get_parent().name)
			areas[i].get_parent().power(outlet, liveStatus)
	
	

func setActive(liveStatus):
	active = liveStatus
	
	if liveStatus:
		get_parent().get_node("Center").set_animation("Active")
	else:
		get_parent().get_node("Center").set_animation("Inactive")
# ELECTRICITY INHERENT FUNCTIONS ================================================
## The primary signal that is called when passing power to an electric object
#func power(outlet : String, liveStatus : bool):
#	pass
