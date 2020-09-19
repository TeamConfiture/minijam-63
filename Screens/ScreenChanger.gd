extends Node

func _change_screen(viewport, event, shape_idx, scene_name):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		Global.goto_scene("res://Screens/" + scene_name + "/" + scene_name + ".tscn")
		Inventory.visible = true
