extends Control
onready var rootNodeScript = get_node("/root/MasterGameScript")

#Makes the easter egg image visible....
#Upon successful trigger, that is!
func _ready():
	if MasterGameScript.showEasterEgg && !rootNodeScript.hasPlayed:
		if !rootNodeScript.isMuted:
			$EasterEggSound.play()
			rootNodeScript.hasPlayed = true
		$Menu/CenterRow/CharacterImage.visible = true

	else:
		if !rootNodeScript.isMuted:
			$TitleMusic.play()

func _on_EasterEggSound_finished():
	if !rootNodeScript.isMuted:	
		$TitleMusic.play()
