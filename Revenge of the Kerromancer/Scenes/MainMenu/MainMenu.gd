extends Control

onready var menu = get_node("CanvasLayer/Menu")
onready var game = get_tree().root.get_node("Game")

func _ready():
	game.loadFlags()
	menu.get_node("Continue").disabled = !game.isFlagTriggered("SaveDataExists")


func _on_New_Game_pressed():
	game.startNewGame()


func _on_Continue_pressed():
	game.continueGame()
