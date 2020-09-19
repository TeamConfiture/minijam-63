extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var myOriginalValue = 0;

var myValue;

# Called when the node enters the scene tree for the first time.
func _ready():
	_changeState(myOriginalValue)

func _changeState(newState: int):
	print("Switched state to ", newState)
	if newState < 0 or newState > 9:
		return false
	myValue = newState
	match newState:
		0:
			self.play("default")
		_:
			self.play(str(newState))

func _deltaState(delta: int, isResetButton: bool, isSetterButton: bool):
	if (isResetButton):
		_changeState(myOriginalValue)
		return
	if (isSetterButton):
		_changeState(delta)
		return
	var newValue = myValue + delta
	while newValue < 0:
		newValue += 10
	while newValue > 9:
		newValue -= 10
	_changeState(newValue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
