extends Node2D

export var size = 5
export var inputs = []
export var outputs = []

var nodes = []
var buttons = {}

var labyTileTemplate =  preload("res://Tests/LabyrintheTile.tscn")
var labyButtonTemplate =  preload("res://Tests/Bouton_laby.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes.clear()
	buttons.clear()
	var temp = 0
	var test = ["default", "i", "T", "I", "r"]
	var theIndex = null
	for i in range(size+2): # selon x
		for j in range(size+2): # selon y
			theIndex = [i,j] # on a donc x;y <=> colonne;ligne <=> i;j
			if ((i == 0 or i == size+1) or (j == 0 or j == size+1) and not (i == 0 or i == size+1) and (j == 0 or j == size+1)):
				print("Created ", theIndex)
				buttons[theIndex] = labyButtonTemplate.instance()
				buttons[theIndex].line=j-1
				buttons[theIndex].col=i-1
				buttons[theIndex].monSens = (i == 0 or i == size+1)
				buttons[theIndex].maDirection = (i == size+1 or j == size+1)
				buttons[theIndex].set_scale(Vector2( .2, .2))
				buttons[theIndex].connect("triggered", self, "_on_Bouton_laby_triggered")
				self.add_child(buttons[theIndex])
	#			nodes[i][j].set_texture(load("res://Docs/PH_Labyrinthe_p.png"))
				buttons[theIndex].set_position(Vector2((i-1)*100, (j-1)*100))
	for i in range(size): # selon x
		nodes.append([])
		for j in range(size): # selon y
			 # on a donc x;y <=> colonne;ligne <=> i;j
			nodes[i].append(labyTileTemplate.instance())
			nodes[i][j].setTileType(test[temp])
#				print(i, ";", j, " got type ", temp, " : ", test[temp])
			temp += 1
			if temp >= 5:
				temp = 0
			self.add_child(nodes[i][j])
#			nodes[i][j].set_texture(load("res://Docs/PH_Labyrinthe_p.png"))
			nodes[i][j].set_position(Vector2(i*100, j*100))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recalculatePath():
	pass

func _on_Bouton_laby_triggered(maDirection, monSens, reset, line, column):
	print("Ayudame por favor, I received a signal to move ", line, ";", column, " in...")
	 # on a donc x;y <=> colonne;ligne <=> i;j
	if monSens:
		var nodeTemp = null
		if maDirection:
			print("bas")
			nodeTemp = nodes[size-1][line]
			for i in range(size-1, 1, -1):
				nodes[i][line] = nodes[i-1][line]
			nodes[0][line] = nodeTemp
		else:
			print("haut")
			nodeTemp = nodes[0][line]
			for i in range(size-1):
				nodes[i][line] = nodes[i+1][line]
			nodes[size-1][line] = nodeTemp
		
		for i in range(size):
			nodes[i][line].set_position(Vector2(i*100, line*100))
		
	else:
		if maDirection:
			print("droite")
			nodes[column].push_front(nodes[column].pop_back())
		else:
			print("gauche")
			nodes[column].push_back(nodes[column].pop_front())
		
		for i in range(size):
			nodes[column][i].set_position(Vector2(column*100, i*100))
			
	recalculatePath()
