extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_PlayButton_pressed():
	Global.goto_scene("res://Screens/Office/Office.tscn")
	Inventory.visible=true

func _on_CreditsButton_pressed():
	Global.goto_scene("res://Global/CreditsScene.tscn")

func _on_ReturnButton_pressed():
	Global.goto_scene("res://Global/Menus/MainMenu.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()	
