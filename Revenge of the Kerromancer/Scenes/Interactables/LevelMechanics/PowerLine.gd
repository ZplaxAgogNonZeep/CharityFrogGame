extends Node2D

var active = false

func _ready():
	if $Connection.animation == "Corner":
		$OutletB.position = $Position2D.position
	

func checkForConnection():
	var OutletA : bool
	if $OutletA.get_overlapping_areas() != []:
		OutletA = true

	var OutletB : bool
	if $OutletB.get_overlapping_areas() != []:
		OutletB = true
