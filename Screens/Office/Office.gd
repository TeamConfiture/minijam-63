extends Node2D

var first_time = true

func _ready():
	if first_time:
		Tasks.action(0)
		first_time = false
