extends Sprite

signal triggered(deltaStep, isResetButton, isSetterButton)

export var myNixies = []

export var myDeltaStep = 0

export var isResetButton = false

export var isSetterButton = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for elem in myNixies:
		self.connect("triggered", get_node(elem), "_deltaState")

func getPressed():
#	print("getPressed")
	emit_signal("triggered", myDeltaStep, isResetButton, isSetterButton)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
