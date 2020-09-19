extends Node2D

export var size = 5
export var inputs = []
export var outputs = []

var nodes = []
var buttons = {}
var inNodes = []
var outNodes = []

var rng = RandomNumberGenerator.new()

var labyTileTemplate =  preload("res://Tests/LabyrintheTile.tscn")
var labyButtonTemplate =  preload("res://Tests/Bouton_laby.tscn")

func generateLab():
	nodes.clear()
	buttons.clear()
	inNodes.clear()
	outNodes.clear()
	var temp = 0
	var test = ["default", "i", "T", "I", "r"]
	var inImgs = ["res://Docs/PH_InputB.png", "res://Docs/PH_InputR.png", "res://Docs/PH_InputV.png"]
	var outImgs = ["res://Docs/PH_OutputB.png", "res://Docs/PH_OutputR.png", "res://Docs/PH_OutputV.png"]
	var theIndex = null
	for i in range(size+2): # selon x
		for j in range(size+2): # selon y
			theIndex = [i,j] # on a donc x;y <=> colonne;ligne <=> i;j
			if (((i == 0 or i == size+1) or (j == 0 or j == size+1)) and not((i == 0 or i == size+1) and (j == 0 or j == size+1))):
#				print("Created ", theIndex)
				buttons[theIndex] = labyButtonTemplate.instance()
				buttons[theIndex].line=j-1
				buttons[theIndex].col=i-1
				buttons[theIndex].monSens = (i == 0 or i == size+1)
				buttons[theIndex].maDirection = (i == size+1 or j == size+1)
				buttons[theIndex].set_scale(Vector2( .2, .2))
				buttons[theIndex].connect("triggered", self, "_on_Bouton_laby_triggered")
				self.add_child(buttons[theIndex])
	#			nodes[i][j].set_texture(load("res://Docs/PH_Labyrinthe_p.png"))
				var x = 0
				var y = 0
				if i == 0:
					x = -100 - 20
				else:
					x = ((i-1) * 100) + 20
				if j == 0:
					y = -100 - 20
				else:
					y = ((j-1) * 100) + 20
				buttons[theIndex].set_position(Vector2(x, y))
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
	temp = 0
	for e in inputs:
		inNodes.append(Sprite.new())
		inNodes[-1].set_texture(load(inImgs[temp]))
		self.add_child(inNodes[-1])
		temp += 1
		if temp >= inImgs.size():
			temp = 0
		var x = 0
		var y = 0
		if (e.x == 0):
			x = -100
		else:
			x = ((e.x-1) * 100)
		if (e.y == 0):
			y = -100
		else:
			y = ((e.y-1) * 100)
		print(e.x, ";", e.y, ";", x, ";", y)
		inNodes[-1].set_position(Vector2(x, y))
	temp = 0
	for e in outputs:
		outNodes.append(Sprite.new())
		outNodes[-1].set_texture(load(outImgs[temp]))
		self.add_child(outNodes[-1])
		temp += 1
		if temp >= outImgs.size():
			temp = 0
		var x = 0
		var y = 0
		if (e.x == 0):
			x = -100
		else:
			x = ((e.x-1) * 100)
		if (e.y == 0):
			y = -100
		else:
			y = ((e.y-1) * 100)
		print(e.x, ";", e.y, ";", x, ";", y)
		outNodes[-1].set_position(Vector2(x, y))
	temp = 0
	
func shuffle():
	var rnd=0
	var rndDir = false
	for i in range(size):
		rnd = rng.randi_range(0,4)
		for j in range(rnd):
			rndDir = (rng.randi_range(0,4) % 2 == 1)
			_on_Bouton_laby_triggered(true, rndDir, false, i, 0)
	for i in range(size):
		rnd = rng.randi_range(0,4)
		for j in range(rnd):
			rndDir = (rng.randi_range(0,4) % 2 == 1)
			_on_Bouton_laby_triggered(rndDir, true, false, 0, i)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	generateLab()
	shuffle()
	shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recalculatePath():
	pass

func _on_Bouton_laby_triggered(maDirection, monSens, reset, line, column):
	if reset:
		generateLab()
		shuffle()
		shuffle()
		return
	
#	print("Ayudame por favor, I received a signal to move ", line, ";", column, " in...")
	 # on a donc x;y <=> colonne;ligne <=> i;j
	if monSens:
		var nodeTemp = null
		if maDirection:
#			print("droite")
			nodeTemp = nodes[size-1][line]
			for i in range(size-1, 0, -1):
#				print(i,";",line," devient ",i-1,";",line)
				nodes[i][line] = nodes[i-1][line]
			nodes[0][line] = nodeTemp
		else:
#			print("gauche")
			nodeTemp = nodes[0][line]
			for i in range(size-1):
				nodes[i][line] = nodes[i+1][line]
			nodes[size-1][line] = nodeTemp
		
		for i in range(size):
			nodes[i][line].set_position(Vector2(i*100, line*100))
		
	else:
		if maDirection:
#			print("bas")
			nodes[column].push_front(nodes[column].pop_back())
		else:
#			print("haut")
			nodes[column].push_back(nodes[column].pop_front())
		
		for i in range(size):
			nodes[column][i].set_position(Vector2(column*100, i*100))
			
	recalculatePath()
