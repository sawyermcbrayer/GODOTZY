extends Control

onready var rootNodeScript = get_node("/root/MasterGameScript")

#On scene load set toggle state from master script
func _ready():
	$OptionsContainer/OptionsMenuContainer/OptionsMenuBGColor/OptionsListContainer/MusicToggle/MusicToggleBoxContainer/MusicToggleBox.pressed = rootNodeScript.isMuted
	if !rootNodeScript.isMuted:
		$OptionsScreenMusic.play()

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")

#Toggle isMuted variable as well as handle music stop start logic for
#options screen
func _on_MusicToggleBox_pressed():
	rootNodeScript.isMuted = !rootNodeScript.isMuted
	if !rootNodeScript.isMuted:
		$OptionsScreenMusic.play()
	else:
		$OptionsScreenMusic.stop()
