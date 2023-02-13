extends VBoxContainer

#
#Main menu button handling script
#

func _on_NewGameButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameScreen/DiceBoard.tscn")

func _on_OptionsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://OptionsScreen/OptionsScene.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
