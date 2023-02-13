extends HBoxContainer

onready var rootScript = get_node("/root/MasterGameScript")

onready var pictureList = [
"res://CHGAssets/Images/dieWhite_border1.png",
"res://CHGAssets/Images/dieWhite_border2.png",
"res://CHGAssets/Images/dieWhite_border3.png",
"res://CHGAssets/Images/dieWhite_border4.png",
"res://CHGAssets/Images/dieWhite_border5.png",
"res://CHGAssets/Images/dieWhite_border6.png"
]

var lockedError = "All dice are in locked state!"
var randNum
var diceValueListOutput = [0,0,0,0,0]
var diceValueList = [0,0,0,0,0]

#Makes the lock functionality active after first roll for all subsequent rolls
#Triggers the die randomization
func _on_RollButton_pressed():
	if !rootScript.CheckLock():
		
		$DiceDock1/VBoxContainer/LockDiceButton.visible = true
		$DiceDock2/VBoxContainer/LockDiceButton.visible = true
		$DiceDock3/VBoxContainer/LockDiceButton.visible = true
		$DiceDock4/VBoxContainer/LockDiceButton.visible = true
		$DiceDock5/VBoxContainer/LockDiceButton.visible = true

		if MasterGameScript.diceOneActive:
			RandomGenerator(0)
			$DiceDock1/VBoxContainer/DiceDockBGColor/BootPicture.texture = load(pictureList[diceValueList[0]])
		if MasterGameScript.diceTwoActive:
			RandomGenerator(1)		
			$DiceDock2/VBoxContainer/DiceDockBGColor/BootPicture.texture = load(pictureList[diceValueList[1]])
		if MasterGameScript.diceThreeActive:
			RandomGenerator(2)
			$DiceDock3/VBoxContainer/DiceDockBGColor/BootPicture.texture = load(pictureList[diceValueList[2]])
		if MasterGameScript.diceFourActive:
			RandomGenerator(3)
			$DiceDock4/VBoxContainer/DiceDockBGColor/BootPicture.texture = load(pictureList[diceValueList[3]])
		if MasterGameScript.diceFiveActive:
			RandomGenerator(4)
			$DiceDock5/VBoxContainer/DiceDockBGColor/BootPicture.texture = load(pictureList[diceValueList[4]])
			
		for num in diceValueList.size():
			diceValueListOutput[num] = diceValueList[num] + 1
	else:
		print("ERROR: " + lockedError)

#RandomGenerator() will both create and update the array holding
#dice values at the active die's index (the variable passed to this method)
func RandomGenerator(id):
		randNum = MasterGameScript.RandomDiceGenerator()
		diceValueList.remove(id)
		diceValueList.insert(id, randNum)
		return randNum
