extends Popup

#
#Simply handles close button pressed() to close the error pop up
#

func _on_InvalidExitButton_pressed():
	self.visible = false
