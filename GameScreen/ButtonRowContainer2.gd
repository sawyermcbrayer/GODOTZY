extends HBoxContainer

#
#Handles scene transition from DiceBoard to main scene
#Calls DiceBoard script to begin dice validation
#

onready var rootScript = get_node("/root/MasterGameScript")
onready var diceBoardScript = get_parent().get_parent()

func _on_GameQuitButton_pressed():
	rootScript.ResetBoard()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")

func _on_RollButton_pressed():
	diceBoardScript.ValidateDiceValues()
