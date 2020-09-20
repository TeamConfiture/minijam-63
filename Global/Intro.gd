extends VideoPlayer


func _on_Intro_finished():
	Global.goto_scene("res://Screens/Office/Office.tscn")
	Inventory.changeVisibility(true)
	Bgm.play()
