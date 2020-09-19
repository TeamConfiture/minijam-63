extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ReturnButton_pressed():
	Global.goto_scene("res://Tests/MainScene.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()	
