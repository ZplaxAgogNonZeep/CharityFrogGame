extends KinematicBody2D

var active := false

var isAPath := false

var speed := .5

var velocity : Vector2 = Vector2.ZERO
var dir : int  = 0





func _on_Tween_tween_all_completed():
	var areas = $Outlet.get_overlapping_areas()
	#print(areas)
	var connection = null
	for i in range(areas.size()):
		if isAPath and areas[i].name == "OutletB":
			#print("OutletB Found")
			connection = areas[i]
				
		elif !isAPath and areas[i].name == "OutletA":
			#print("OutletA Found")
			connection = areas[i]
			
	if connection == null:
		#print("Reverse Called")
		isAPath = !isAPath

		for i in range(areas.size()):
			if isAPath and areas[i].name == "OutletB":
				connection = areas[i]
					
			elif !isAPath and areas[i].name == "OutletA":
				connection = areas[i]

	var start
	var end
	if connection != null:
		#print("gathering node positions")
		if connection.get_parent().active:
			start = connection.global_position
			if isAPath:
				end = connection.get_parent().get_node("A").global_position
			else:
				end = connection.get_parent().get_node("B").global_position
			#print("Calling movePlatform")
			movePlatform(end)
		
	

func movePlatform(end):
	#print("Moving towords outlet at position " + str(end))
	$Tween.interpolate_property(self, "position", position, end, 1)
	$Tween.start()

# The primary signal that is called when passing power to an electric object
func power(outlet : String, liveStatus : bool):
	#print("RAIL PLATFORM CALLED")
	if outlet == "OutletA":
		isAPath = true
	else:
		isAPath = false
	
	var areas = $Outlet.get_overlapping_areas()
	var connection = null
	for i in range(areas.size()):
		if isAPath and areas[i].name == "OutletB":
			connection = areas[i]
				
		elif !isAPath and areas[i].name == "OutletA":
			connection = areas[i]

	var end
	if connection != null:
		
		if isAPath:
			end = connection.get_parent().get_node("A").global_position
		else:
			end = connection.get_parent().get_node("B").global_position
	
		movePlatform(end)

# ELECTRICITY INHERENT FUNCTIONS ================================================
## The primary signal that is called when passing power to an electric object
#func power(outlet : String, liveStatus : bool):
#	pass
