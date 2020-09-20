extends Node

func _change_screen(viewport, event, shape_idx, scene_name: String):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if scene_name.begins_with("Archive"):
			Tasks.action(26)
		Global.goto_scene("res://Screens/" + scene_name + "/" + scene_name + ".tscn")
		Inventory.visible = true
		if scene_name.begins_with("Hangar"):
			Tasks.action(2)
		#Tasks.triggerChangeScreen(24)