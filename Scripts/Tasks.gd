extends Node

var current_scene = null

export var taskStatus = [1] # tab de bool
export var taskInheritance = [2] # liste de liste d'int
var taskActionPointer = [] # tab de pointeurs de fonction
	

func dummyAction(actionId: int):
	print("Action ", actionId, "was called !")

func _ready():
	taskStatus.clear()
	taskInheritance.clear()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
	for i in range(3):
		if i != 0:
			taskStatus.push_back(false)
			taskInheritance.push_back([i-1])
		else:
			taskStatus.push_back(true)
			taskInheritance.push_back([])
		taskActionPointer.push_back(funcref(self, "dummyAction"))
		#print(taskStatus)
		#print(taskInheritance)
		#print("====")

func action(actionNumber: int):
	if taskStatus.size() <= actionNumber:
		return false
	if taskStatus[actionNumber]:
		return false
#	print(taskInheritance)
#	print(actionNumber)
	for task in taskInheritance[actionNumber]:
#		print(task)
		if not taskStatus[task]:
			return false
	print("Calling with ",actionNumber)
	taskActionPointer[actionNumber].call_func(actionNumber)
	taskStatus[actionNumber] = true
	return true


