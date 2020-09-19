extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(ev):
	if Input.is_action_pressed("ui_pause") or Input.is_key_pressed(KEY_ESCAPE):
		Global.goto_scene("res://Global/Menus/PauseScene.tscn")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print("Object Click")
		else: 
			print("Object Release")
