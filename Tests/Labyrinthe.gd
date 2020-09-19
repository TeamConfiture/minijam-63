extends Node2D

export var size = 5
export var inputs = []
export var outputs = []

var nodes = []

var labyTileTemplate =  preload("res://Tests/LabyrintheTile.tscn")
var labyButtonTemplate =  preload("res://Tests/Bouton_laby.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes.clear()
	var temp = 0
	var test = ["default", "i", "T", "I", "r"]
	for i in range(size+1):
		nodes.append([])
		for j in range(size+1):
			if ((i == 0 or i == size+1) or (j == 0 or j == size+1) and not (i == 0 or i == size+1) and (j == 0 or j == size+1)):
				nodes[i].append(labyButtonTemplate.instance())
				nodes[i][j].line=i
				nodes[i][j].col=j
				nodes[i][j].monSens = (i == 0 or i == size-1)
				nodes[i][j].maDirection = (i == size-1 or j == size-1)
				nodes[i][j].set_scale(Vector2( .2, .2))
				nodes[i][j].connect("triggered", self, "_on_Bouton_laby_triggered")
			else:
				nodes[i].append(labyTileTemplate.instance())
				nodes[i][j].setTileType(test[temp])
#				print(i, ";", j, " got type ", temp, " : ", test[temp])
				temp += 1
				if temp >= 5:
					temp = 0
			self.add_child(nodes[i][j])
#			nodes[i][j].set_texture(load("res://Docs/PH_Labyrinthe_p.png"))
			nodes[i][j].set_position(Vector2((i+1)*100, (j+1)*100))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recalculatePath():
	pass

func _on_Bouton_laby_triggered(maDirection, monSens, reset, line, column):
	print("Ayudame por favor, I received a signal to move ", line, ";", column, " in...")
	if monSens:
		if maDirection:
			print("droite")
			var tempNode = nodes[line].pop_back()
			var tempNode2 = nodes[line].pop_front()
			nodes[line].push_front(nodes[line].pop_back())
			nodes[line].push_front(tempNode2)
			nodes[line].push_back(tempNode)
		else:
			print("gauche")
			var tempNode = nodes[line].pop_back()
			var tempNode2 = nodes[line].pop_front()
			nodes[line].push_back(nodes[line].pop_front())
			nodes[line].push_front(tempNode2)
			nodes[line].push_back(tempNode)
		
		for i in range(size+1):
			nodes[line][i].set_position(Vector2((line+1)*100, (i+1)*100))
		
	else:
		var nodeTemp = null
		if maDirection:
			print("bas")
			nodeTemp = nodes[size-1][column]
			for i in range(size-1, 1, -1):
				nodes[i][column] = nodes[i-1][column]
			nodes[0][column] = nodeTemp
		else:
			print("haut")
			nodeTemp = nodes[0][column]
			for i in range(size-1):
				nodes[i][column] = nodes[i+1][column]
			nodes[size-1][column] = nodeTemp
		
		for i in range(size+1):
			nodes[i][column].set_position(Vector2((i+1)*100, (column+1)*100))
			
	recalculatePath()
