extends Node

const TestMagic1 = "res://KerromancerPlayer/Magic/Spells/TestMagic1/TestMagic1.tscn"
const TestMagic2 = "res://KerromancerPlayer/Magic/Spells/TestMagic2/TestMagic2.tscn"
const TestMagic3 = "res://KerromancerPlayer/Magic/Spells/TestMagic3/TestMagic3.tscn"

const testDict = {"TestMagic1" : TestMagic1}

func searchWeaponIndex(name):
	pass

func searchMagicIndex(name):
	preload(TestMagic1)
