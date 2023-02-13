extends Control

#Init Variables
onready var rootNodeScript = get_node("/root/MasterGameScript")
var turnScore = 0
var turnCount = 1
var comboType = ""
var defaultMessage = "Sorry, no combo!"

func _ready():
	if !rootNodeScript.isMuted:
		$DiceBoardMusic.play()

func ValidateDiceValues():
	#Check state of dice locks before initiating validation events
	if !rootNodeScript.CheckLock():
		if !rootNodeScript.isMuted:
			$DiceRollSound.play()

		#Retrieve & sort diceValidateList - (contains dice values for validation)
		turnScore = 0
		var successCounter = 0
		var diceValidateList = $DiceBoardContainer/DiceRowContainer.diceValueListOutput
		diceValidateList.sort()

		#Sum dice values for turnScore each roll
		for die in diceValidateList.size():
			turnScore += diceValidateList[die]

		#Combo type DEFAULT MESSAGE
		comboType = defaultMessage

		#2/3/4/FullHouse - LOGIC START
		#Sum occurrences of same numbers in diceValidateList and 
		#store results in duplicateArray
		var duplicateArray = [0,0,0,0,0,0]
		for num in duplicateArray.size():
			for subNum in diceValidateList.size():
				if diceValidateList[subNum] == num + 1:
					duplicateArray[num] += 1

		#2x and 3x dice duplicate flags - if both are true then a 2x and 3x occurence of dice
		#has occurred.
		var threeFlag = false
		var twoFlag = false

		#VALIDATION TESTING ARRAY:
		#To use test array, copy and paste the following code snip and adjust values as needed
		#Example:
		#duplicateArray = [0,0,0,2,3,0]

		for num in duplicateArray.size():
			if duplicateArray[num] == 2:
				twoFlag = true
				comboType = "TWO of a Kind!"
				print("TWO of a Kind Event Triggered")
			elif duplicateArray[num] == 3:
				threeFlag = true
				comboType = "THREE of a Kind!"
				print("THREE of a Kind Event Triggered")
			elif duplicateArray[num] == 4:
				comboType = "FOUR of a Kind!"
				print("FOUR of a Kind Event Triggered")	
		if threeFlag and twoFlag:
				comboType = "Full House!"
				print("FULL HOUSE Event Triggered")

		#GODOTZY! - LOGIC START
		#VALIDATION TESTING ARRAY:
		#To use test array, copy and paste or uncomment the following code snip and adjust values as needed
		#Example:
		#diceValidateList = [6,6,6,6,6]
		var isGoDotzy = true
		for die in diceValidateList.size() - 1:
			if diceValidateList[die] != diceValidateList[die + 1]:
				 isGoDotzy = false
		if isGoDotzy:
			print("GODOTZY! Event Triggered!")
			rootNodeScript.showEasterEgg = true
			if !rootNodeScript.isMuted:
				$WinSound.play()
			comboType = "Nice GODOTZY!"
		#GODOTZY! - LOGIC END
	
		#Small Straight - LOGIC START
		#VALIDATION TESTING ARRAY:
		#To use test array, copy and paste or uncomment the following code snip and adjust values as needed
		#Example:
		#diceValidateList = [1,2,3,4,5]
		
		#Criteria: Dice have the faces 1,2,3,4,5
		#Since the array is sorted pre validation check, if diceValidateList[0] != 1,
		#then dice roll cannot be of type SmallStraight
		successCounter = 0
		if diceValidateList[0] == 1:
			#If the checked dice + 1 is equal the next diceValidateList index, then pattern iteration is successful
			for die in diceValidateList.size():
				if diceValidateList[die] + 1 == die + 2:
					 successCounter += 1
			#Check if enough successful pattern iterations have been completed
			if successCounter == 5:
				print("1-5 Small Straight Event Occurred")
				comboType = "Small Straight"
		#Small Straight - LOGIC END

		#Large Straight - LOGIC START
		#VALIDATION TESTING ARRAY:
		#To use test array, copy and paste or uncomment the following code snip and adjust values as needed
		#Example:
		#diceValidateList = [2,3,4,5,6]
		
		#Criteria: Dice have the faces 2,3,4,5,6
		#Since the array is sorted pre validation check, if diceValidateList[0] != 1,
		#then dice roll cannot be of type SmallStraight
		successCounter = 0
		if diceValidateList[0] == 2:
			for die in diceValidateList.size():
				if diceValidateList[die] + 1 == die + 3:
					 successCounter += 1
			if successCounter == 5:
				comboType = "Large Straight"
				print("Large Straight Event Fired")
		#Large Straight - LOGIC END
		
		#If no combinations are valid, play losing sound
		if comboType == defaultMessage && !rootNodeScript.isMuted:
			$LoseSound.play()
		#Update board labels etc with newly validated values
		_UpdateBoard()
		
		#Dice Logic - END
	else:
		#In the event of all dice being locked, throw error/instruction prompt
		$InvalidPopUp.visible = true

#Update board labels etc with newly validated values
func _UpdateBoard():
		rootNodeScript.totalScore += turnScore
		$DiceBoardContainer/DiceBoardScoreHContainer/DiceBoardScoreVContainer/ScoreLabel.text = "Total Score: " + str(rootNodeScript.totalScore) + "\nTurn " + str(turnCount) + " Score: " + str(turnScore) +"\nCombo: " + comboType
		turnCount += 1	
		
#Handling of DiceBoard's instruction popup opening and closing
func _on_InstructionsButton_pressed():
	$InstructionsPopUp.visible = true
	
func _on_CloseInstructionsButton_pressed():
	$InstructionsPopUp.visible = false
