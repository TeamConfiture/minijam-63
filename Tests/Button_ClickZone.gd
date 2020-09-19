extends Area2D

signal clicked();

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func onArea2Dinputevent( viewport, event, shapeidx ):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		# var scene = get_node(".");
		print("Zone Triggered")
		emit_signal("clicked");

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
