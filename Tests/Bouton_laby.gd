extends Sprite

signal triggered(maDirection, monSens, reset, line, column)

export var maDirection = false # false = gauche/haut

export var monSens = false # false = horizontal

export var reset = false # resetPuzzle

export var line = 0 # 0;n-1

export var col = 0 # 0;n-1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func getPressed():
	print("getPressed")
	emit_signal("triggered", maDirection, monSens, reset, line, col)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
