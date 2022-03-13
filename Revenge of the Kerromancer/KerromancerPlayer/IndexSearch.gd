extends Node

const TestGun1 = "res://KerromancerPlayer/Weapons/TestGun1/TestGun1.tscn"

const TestMagic1 = "res://KerromancerPlayer/Magic/Spells/TestMagic1/TestMagic1.tscn"
const TestMagic2 = "res://KerromancerPlayer/Magic/Spells/TestMagic2/TestMagic2.tscn"
const TestMagic3 = "res://KerromancerPlayer/Magic/Spells/TestMagic3/TestMagic3.tscn"
const PuffofSmoke = "res://KerromancerPlayer/Magic/Spells/PuffofSmoke.tscn"
const TailwindLunge = "res://KerromancerPlayer/Magic/Spells/TailwindLunge.tscn"
const BouncingBubble = "res://KerromancerPlayer/Magic/Spells/BouncingBubble.tscn"

const TestScene = "res://TestScenes/TestScene.tscn"

func searchWeaponIndex(name):
	match name:
		"TestGun1":
			return preload(TestGun1)
		_:
			return null

func searchMagicIndex(name):
	match name:
		"TestMagic1":
			return preload(TestMagic1)
		"TestMagic2":
			return preload(TestMagic2)
		"TestMagic3":
			return preload(TestMagic3)
		"PuffofSmoke":
			return preload(PuffofSmoke)
		"TailwindLunge":
			return preload(TailwindLunge)
		"BouncingBubble":
			return preload(BouncingBubble)
		_:
			return null

func searchLevelIndex(name):
	match name:
		"TestScene":
			return preload(TestScene)
		_:
			return null
