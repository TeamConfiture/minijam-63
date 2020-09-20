extends Node

var current_scene = null

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
	

func dummyAction(actionId: int):
	print("Action ", actionId, "was called !")

func createStateChart():
		
	# 0: EVB0_01
	# Dep : none
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 1: EVB0_02
	# Dep : none
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 2: EVE0_01
	# Dep : EVB0_02
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([1])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 3: EVE0_02
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 4: EVE0_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 5: EVL0_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 6: EVB1_01
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 7: EVB1_02
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 8: EVB1_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 9: EVB1_04
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 10: EVB1_05
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 11: EVB1_06
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 12: EVE1_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 13: EVE1_02
	# Dep : EVE0_01, EVB1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2, 6])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 14: EVE1_03
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 15: EVE1_04
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 16: EVE1_05
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 17: EVL1_01
	# Dep : EVE0_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 18: EVL1_02
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 19: EVE1_06
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 20: EVE1_07
	# Dep : EVE0_01
	# Repeat : inf until EV1_09
	taskStatus.push_back([false, 22])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 21: EVE1_08
	# Dep : EVE0_01
	# Repeat : inf until EV1_09
	taskStatus.push_back([false, 22])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 22: EVE1_09
	# Dep : EVE0_01, EVE1_06
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2,19])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 23: EVE1_11
	# Dep : EVE0_01, EVE1_09
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 24: EVP1_01
	# Dep : EVE0_01, EVE1_09
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 25: EVP1_02
	# Dep : EVE0_01, EVE1_09
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,22])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 26: EVE1_10
	# Dep : EVE0_01, EVP1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,24])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 27: EVI1_01
	# Dep : EVE0_01,EVB1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,6])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 28: EVI1_02
	# Dep : EVE0_01, EVP1_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([2,24])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 29: EVA2_01
	# Dep : EVE0_01
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([2])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 30: EVA0_01
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 31: EVA2_02
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 32: EVA2_03
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 33: EVA2_04
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 34: EVA2_05
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 35: EVA2_06
	# Dep : EVE0_01, EVA2_01, EVA2_03
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29,32])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 36: EVA2_07
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 37: EVA2_08
	# Dep : EVE0_01, EVA2_01
	# Repeat : inf
	taskStatus.push_back([false, -1])
	taskInheritance.push_back([12,29])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	# 38: EVA2_09
	# Dep : EVE0_01, EVA2_01, EVA2_08
	# Repeat : once
	taskStatus.push_back([false, 1])
	taskInheritance.push_back([12,29,37])
	taskActionPointer.push_back(funcref(self, "dummyAction"))
	
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
	if taskStatus[actionNumber]:
		return false
	for task in taskInheritance[actionNumber]:
		if not taskStatus[task]:
			return false
	print("Calling with ",actionNumber)
	taskActionPointer[actionNumber].call_func(actionNumber)
	taskStatus[actionNumber] = true
	return true


