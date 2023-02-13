extends Node

#Init dice locking variables
var diceOneActive = true
var diceTwoActive = true
var diceThreeActive = true
var diceFourActive = true
var diceFiveActive = true
var hasPlayed = false
var fullLock = false
var showEasterEgg = false
var isMuted = false
var totalScore = 0

#Checks if all dice are in locked state upon "Roll Dice" button press
#Returns true OR false
func CheckLock():
	if !diceOneActive and !diceTwoActive and !diceThreeActive and !diceFourActive and !diceFiveActive:
		fullLock = true
	else:
		fullLock = false
	return fullLock

#Working component of dice randomization 
#Returns (1) random num 
func RandomDiceGenerator():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0,5)
	return num

#Reset the DiceBoard upon game screen exit to main menu
func ResetBoard():
	totalScore = 0
	diceOneActive = true
	diceTwoActive = true
	diceThreeActive = true
	diceFourActive = true
	diceFiveActive = true

