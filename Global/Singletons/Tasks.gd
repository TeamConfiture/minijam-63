extends Node

#var current_scene = null

export var taskStatus = [1] # tab de bool
export var taskInheritance = [2] # liste de liste d'int
var taskActionPointer = [] # tab de pointeurs de fonction
	
##### ABOUT STRUCTURES #####
# taskStatus : List[taskNb] of List[2]
#  |-> [0]: bool (Was the task done at least once)
#  |-> [1]: int (Condition of repeat)
#           |-> 1 => Once
#           |-> -1 => Infinite
#           |-> >1 => Until actionNb is complete
# taskInheritance : List[taskNb] of List[variableSize] of taskNbs
# taskActionPointer : List[taskNb] of function pointer
#  |-> Which function to call when action is triggered

var dialogueTemplate =  preload("res://Dialogues/Dialogue.tscn")
var miniGameLaby =  preload("res://MiniGame/Labyrinthe/Scene_Labyrinthe.tscn")
var miniGameLockpick =  preload("res://MiniGame/Lockpicking/Lock.tscn")
var miniGameShell =  preload("res://MiniGame/Shell/Shell.tscn")

func dummyAction(actionId: int):
	print("Dummy action ", actionId, "was called !")

func triggerDialogue(actionId: int):
	var newDialogue = dialogueTemplate.instance()
	print("We should trigger a dialogue for task id ",actionId, " here !")
	match actionId:
		0:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B0_01.json"
		2:
			print("Dialogue for 2")
		6:
			print("Dialogue for 6")
		7:
			print("Dialogue for 7")
		8:
			print("Dialogue for 8")
		9:
			print("Dialogue for 9")
		10:
			print("Dialogue for 10")
		12:
			print("Dialogue for 12")
		13:
			print("Dialogue for 13")
		14:
			print("Dialogue for 14")
		15:
			print("Dialogue for 15")
		16:
			print("Dialogue for 16")
		17:
			print("Dialogue for 17")
		20:
			print("Dialogue for 20")
		21:
			print("Dialogue for 21")
		26:
			print("Dialogue for 26")
		29:
			print("Dialogue for 29")
		31:
			print("Dialogue for 31")
		33:
			print("Dialogue for 33")
		34:
			print("Dialogue for 34")
		35:
			print("Dialogue for 35")
		36:
			print("Dialogue for 36")
		37:
			print("Dialogue for 37")
		_:
			print("Unrecognised event id : ", actionId)
			return false
	get_tree().get_root().add_child(newDialogue)
	newDialogue.start_dialogue()
	
func triggerChangeScreen(actionId: int):
	print("We should trigger a scene change for task id ",actionId, " here !")
	match actionId:
		_:
			print("Unrecognised event id : ", actionId)
	# Global.goto_scene("res://Screens/" + scene_name + "/" + scene_name + ".tscn")

func triggerMinigame(actionId: int):
	print("We should trigger a minigame for task id ",actionId, " here !")
	var sceneInstance = null
	match actionId:
		18:
			print("Item handling for 18")
			sceneInstance = miniGameLaby.instance()
		22:
			print("Item handling for 22")
			sceneInstance = miniGameLockpick.instance()
		32:
			print("Item handling for 32")
			sceneInstance = miniGameShell.instance()
		_:
			print("Unrecognised event id : ", actionId)
	self.add_child(sceneInstance)

func triggerCinematic(actionId: int):
	print("We should trigger a cinematic for task id ",actionId, " here !")
	match actionId:
		11:
			print("Starting cinematic for 11")
		38:
			print("Starting cinematic for 38")
		_:
			print("Unrecognised event id : ", actionId)

func triggerItemInventory(actionId: int):
	print("We should handle an item event for task id ",actionId, " here !")
	match actionId:
		19:
			print("Item handling for 19")
		24:
			print("Item handling for 24")
		27:
			print("Item handling for 27")
		28:
			print("Item handling for 28")
		_:
			print("Unrecognised event id : ", actionId)

func createStateChart():
	# 0: EVB0_01
	# Dep : none
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 1: EVB0_02
	# Dep : none
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 2: EVE0_01
	# Dep : EVB0_02
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([1])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 3: EVE0_02
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 4: EVE0_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 5: EVL0_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 6: EVB1_01
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 7: EVB1_02
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 8: EVB1_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 9: EVB1_04
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 10: EVB1_05
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 11: EVB1_06
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerCinematic"))
	# 12: EVE1_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 13: EVE1_02
	# Dep : EVE0_01, EVB1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2, 6])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 14: EVE1_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 15: EVE1_04
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 16: EVE1_05
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 17: EVL1_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 18: EVL1_02
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerMinigame"))
	# 19: EVE1_06
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerItemInventory"))
	# 20: EVE1_07
	# Dep : EVE0_01
	# Repeat : inf until EV1_09
	taskStatus.push_back([false, 22])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 21: EVE1_08
	# Dep : EVE0_01
	# Repeat : inf until EV1_09
	taskStatus.push_back([false, 22])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 22: EVE1_09
	# Dep : EVE0_01, EVE1_06
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2,19])
	taskActionPointer.push_back(funcref(self, "triggerMinigame"))
	# 23: EVE1_11
	# Dep : EVE0_01, EVE1_09
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 24: EVP1_01
	# Dep : EVE0_01, EVE1_09
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "triggerItemInventory"))
	# 25: EVP1_02
	# Dep : EVE0_01, EVE1_09
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 26: EVE1_10
	# Dep : EVE0_01, EVP1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,24])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 27: EVI1_01
	# Dep : EVE0_01,EVB1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,6])
	taskActionPointer.push_back(funcref(self, "triggerItemInventory"))
	# 28: EVI1_02
	# Dep : EVE0_01, EVP1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,24])
	taskActionPointer.push_back(funcref(self, "triggerItemInventory"))
	# 29: EVA2_01
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 30: EVA0_01
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "triggerChangeScreen"))
	# 31: EVA2_02
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 32: EVA2_03
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "triggerMinigame"))
	# 33: EVA2_04
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 34: EVA2_05
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 35: EVA2_06
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 36: EVA2_07
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 37: EVA2_08
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 38: EVA2_09
	# Dep : EVE0_01, EVA2_01, EVA2_08
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([12,29,37])
	taskActionPointer.push_back(funcref(self, "triggerCinematic"))
	
#	for i in range(3):
#		if i != 0:
#			taskStatus.push_back(false)
#			taskInheritance.push_back([i-1])
#		else:
#			taskStatus.push_back(true)
#			taskInheritance.push_back([])

func _ready():
	taskStatus.clear()
	taskInheritance.clear()
	taskActionPointer.clear()
	createStateChart()

func action(actionNumber: int):
	if taskStatus.size() <= actionNumber:
		return false
	for task in taskInheritance[actionNumber]:
		if not taskStatus[task][0]:
			return false
	if taskStatus[actionNumber][1] != -1:
		if taskStatus[actionNumber][0] == true and taskStatus[actionNumber][1]==1:
			return false
		elif taskStatus[taskStatus[actionNumber][1]][0] == true:
			return false
	print("Calling with ",actionNumber)
	taskActionPointer[actionNumber].call_func(actionNumber)
	taskStatus[actionNumber][0] = true
	return true


