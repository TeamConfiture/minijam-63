extends VideoPlayer

func _process(_delta):
	if Input.is_action_pressed("ui_select"):
		self.stop()
		_on_Intro_finished()

func _on_Intro_finished():
	Global.goto_scene("res://Screens/Office/Office.tscn")
	Inventory.changeVisibility(true)
	Bgm.play()
