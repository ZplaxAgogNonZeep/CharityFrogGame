extends Node

const TestGun1 = "res://KerromancerPlayer/Weapons/TestGun1/TestGun1.tscn"

const TestMagic1 = "res://KerromancerPlayer/Magic/Spells/TestMagic1/TestMagic1.tscn"
const TestMagic2 = "res://KerromancerPlayer/Magic/Spells/TestMagic2/TestMagic2.tscn"
const TestMagic3 = "res://KerromancerPlayer/Magic/Spells/TestMagic3/TestMagic3.tscn"

func searchWeaponIndex(name):
	match name:
		"TestGun1":
			return preload(TestGun1)

func searchMagicIndex(name):
	match name:
		"TestMagic1":
			return preload(TestMagic1)
		"TestMagic2":
			return preload(TestMagic2)
		"TestMagic3":
			return preload(TestMagic3)
		_:
			return null
