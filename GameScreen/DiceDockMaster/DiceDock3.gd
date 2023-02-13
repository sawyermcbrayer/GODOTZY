extends VBoxContainer

#
#DiceDock1-5 are fundamentally the same. These scripts handle the
#lock button font color and active flag toggling for each dice dock
#

onready var rootScript = get_node("/root/MasterGameScript")

func _on_LockDiceButton_pressed():
	rootScript.diceThreeActive = !rootScript.diceThreeActive
	LockFontChanger()
	
func LockFontChanger():
	if !rootScript.diceThreeActive:
		$VBoxContainer/LockDiceButton/LockDiceLabel.set("custom_colors/font_color",Color(255,0,0))
	else:
		$VBoxContainer/LockDiceButton/LockDiceLabel.set("custom_colors/font_color",Color(200,200,200))
