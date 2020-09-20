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

#func _on_dialogue_E2A_endV():
#	print("_on_dialogue_E2A_endV")
#	action(30)

func _on_dialogue_E2A_end():
	print("_on_dialogue_E2A_end")
	action(29)
	action(30)

func _on_dialogue_A2_02_end():
	get_tree().call_group("cabinet", "set_visible", true)

func _on_dialogue_badge():
	print("_on_dialogue_badge")
	triggerItemInventory(27)

func _on_dialogue_JanitorCle_end():
	print("_on_dialogue_JanitorCle_end")
	triggerItemInventory(21)

func _on_dialogue_Laby_end():
	print("_on_dialogue_Laby_end")
	triggerMinigame(18)

func _on_laby_end():
	print("_on_laby_end")
	triggerItemInventory(19)

func _on_locky_end():
	print("lockpicking_end")
#	triggerChangeScreen(19)
	action(23)

func dummyAction(actionId: int):
	print("Dummy action ", actionId, "was called !")

func triggerDialogue(actionId: int):
	var newDialogue = dialogueTemplate.instance()
	print("We should trigger a dialogue for task id ",actionId, " here !")
	match actionId:
		0:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B0_01.json"
		2:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E0_01.json"
		6:
			newDialogue.connect("end_dialogue", self, "_on_dialogue_badge")
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B1_01.json"
		7:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B1_02.json"
		8:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B1_03.json"
		9:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B1_04.json"
		10:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Office/B1_05.json"
		12:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_01.json"
		13:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_02.json"
		14:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_03.json"
		15:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_04.json"
		16:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_05.json"
		17:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Laverie/L1_01.json"
		18:
			newDialogue.connect("end_dialogue", self, "_on_dialogue_Laby_end")
			newDialogue.dialogue_file = "res://Assets/Dialogues/Laverie/L1_02.json"
		19:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_06.json"
			newDialogue.connect("end_dialogue", self, "_on_dialogue_JanitorCle_end")
		20:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_07.json"
		21:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_08.json"
		26: # Transition Entrepot -> Archive
			newDialogue.connect("end_dialogue", self, "_on_dialogue_E2A_end")
			newDialogue.dialogue_file = "res://Assets/Dialogues/Entrepot/E1_10.json"
		29:
#			newDialogue.connect("end_dialogue", self, "_on_dialogue_E2A_endV")
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_01.json"
		31:
			newDialogue.connect("end_dialogue", self, "_on_dialogue_A2_02_end")
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_02.json"
		32:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_03.json"
		33:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_04.json"
		34:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_05.json"
		35:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_06.json"
		36:
			newDialogue.dialogue_file = "res://Assets/Dialogues/Archives/A2_07.json"

		_:
			print("Unrecognised event id : ", actionId)
			return false
	get_tree().get_root().add_child(newDialogue)
	newDialogue.start_dialogue()
	
func triggerChangeScreen(actionId: int):
	print("We should trigger a scene change for task id ",actionId, " here !")
	match actionId:
		23:
			Global.goto_scene("res://Screens/Placard/Placard.tscn")
		30:
			Global.goto_scene("res://Screens/Archives/Archives.tscn")
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
			sceneInstance.connect("end_minigame", self, "_on_laby_end")
		22:
			print("Item handling for 22")
			sceneInstance = miniGameLockpick.instance()
			sceneInstance.connect("lockpicking_end", self, "_on_locky_end")
		37:
			print("Item handling for 37")
			sceneInstance = miniGameShell.instance()
		_:
			print("Unrecognised event id : ", actionId)
	get_tree().get_root().add_child(sceneInstance)
#	self.add_child(sceneInstance)

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
			Inventory._on_add_inventory_item("TenueBroom")
		21:
			print("Item handling for 21")
			Inventory._on_add_inventory_item("ClefPlacard")
		24:
			print("Item handling for 24")
			Inventory._on_add_inventory_item("PassBroom")
		27:
			print("Item handling for 27")
			Inventory._on_add_inventory_item("PassPlayer")
		28:
			print("Item handling for 28")
		_:
			print("Unrecognised event id : ", actionId)

func createStateChart():
	# 0: EVB0_01
	# Dep : none
	# Repeat : once
	taskStatus.push_back([false, -2])
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
	taskStatus.push_back([false, -2])
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
	# Dep : EVE0_01 => none
	# Repeat : once
	taskStatus.push_back([false, -2])
	#taskInheritance.push_back([2])
	taskInheritance.push_back([])
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
	taskActionPointer.push_back(funcref(self, "triggerCinematic")) # ordre de licenciement
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
	taskStatus.push_back([false, -2])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 19: EVE1_06
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, -2])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
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
	taskStatus.push_back([false, -2])
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
	taskStatus.push_back([false, -2])
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
	# Repeat : once => inf
	taskStatus.push_back([false, -2]) # -1
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
	# 30: EVA0_01
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([29]) # 12,
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
	taskActionPointer.push_back(funcref(self, "triggerDialogue"))
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
	taskActionPointer.push_back(funcref(self, "triggerMinigame"))
	# 38: EVA2_09
	# Dep : EVE0_01, EVA2_01, EVA2_08
	# Repeat : once
	taskStatus.push_back([false, -2])
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
		if taskStatus[actionNumber][0] == true and taskStatus[actionNumber][1]==-2:
			return false
		elif taskStatus[taskStatus[actionNumber][1]][0] == true:
			return false
	print("Calling with ",actionNumber)
	taskActionPointer[actionNumber].call_func(actionNumber)
	taskStatus[actionNumber][0] = true
	return true


