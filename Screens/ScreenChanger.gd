extends Node

func _change_screen(_viewport, event, _shape_idx, scene_name: String):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if scene_name.begins_with("Archive"):
			Tasks.action(26)
			return
		Global.goto_scene("res://Screens/" + scene_name + "/" + scene_name + ".tscn")
		Inventory.changeVisibility(true)
		if scene_name.begins_with("Hangar"):
			Tasks.action(1)
		#Tasks.triggerChangeScreen(24)
