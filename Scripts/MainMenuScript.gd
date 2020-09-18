extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_PlayButton_pressed():
	Global.goto_scene("res://Scenes/MainScene.tscn")
