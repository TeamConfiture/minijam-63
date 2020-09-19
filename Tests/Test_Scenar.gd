extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var step=0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	changeStep(0);

func changeStep(step: int):
	var label = get_node("main_label");
	match step:
		0:
			label.text = "Step 0";
		1:
			label.text = "Step 1";
		2:
			label.text = "Step 2";
		_:
			label.text = "Step unknown";

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _step(newStep: int):
	print("Called with ", newStep)
	if (newStep == step + 1):
		step = newStep;
		changeStep(step);

