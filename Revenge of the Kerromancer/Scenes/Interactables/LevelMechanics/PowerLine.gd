extends Node2D

var active = false

func _ready():
	if $Connection.animation == "Corner":
		$OutletB.position = $Position2D.position

func power(outlet, liveStatus):
	setActive(liveStatus)
	var connection = null
	
	if outlet == "OutletA":
		if $OutletB.get_overlapping_areas().size() > 0:
			connection = $OutletB.get_overlapping_areas()[0]
	elif outlet == "OutletB":
		if $OutletA.get_overlapping_areas().size() > 0:
			connection = $OutletA.get_overlapping_areas()[0]
	
	if connection != null:
		connection.power(connection.name, liveStatus)

func setActive(status):
	active = status
	if active:
		$Center.set_animation("Active")
	else:
		$Center.set_animation("Inactive")


# ELECTRICITY INHERENT FUNCTIONS ================================================

#func power(outlet, liveStatus):
#	pass

