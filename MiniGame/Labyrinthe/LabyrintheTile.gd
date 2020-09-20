extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var myType = "default"
export var myRotate = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func rotateTile(angle: int):
	myRotate = angle
	self.rotate(-1 * myRotate*PI/2)

func setTileType(newType: String):
	myRotate = 0
	match newType:
		"default", "+", "p":
			myType = "default"
			self.play("default")
		"I":
			myType = "I"
			self.play("I")
		"T":
			myType = "T"
			self.play("T")
		"i":
			myType = "i"
			self.play("i")
		"r":
			myType = "r"
			self.play("r")
		_:
			print("Unknown ", newType, " tile type")
	self.rotate(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
