extends Node2D

signal lockpicking_end()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Cursor.change_cursor("key")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LockHole_success():
	queue_free()
	Cursor.change_cursor("cursor1")
	emit_signal("lockpicking_end")
	pass # Replace with function body.
