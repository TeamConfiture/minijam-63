extends Node2D

signal end_minigame()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("===Starting laby===")
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Labyrinthe_end_minigame():
	print("Laby minigame succeed")
	queue_free()
	emit_signal("end_minigame")
