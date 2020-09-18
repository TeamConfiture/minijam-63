extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_PlayButton_pressed():
	Global.goto_scene("res://Scenes/MainScene.tscn")

func _on_CreditsButton_pressed():
	Global.goto_scene("res://Scenes/CreditsScene.tscn")

func _on_ReturnButton_pressed():
	Global.goto_scene("res://Scenes/MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()	
