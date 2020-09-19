extends Node

var default_cursor

#enum {CURSOR_LOOK, CURSOR_WALK, CURSOR_TALK} # 0, 1, 2
#
#var n_cursors = 3
#var cursors = {
#	CURSOR_LOOK: "res://Assets/Cursors/cursor1.png", #0
#	CURSOR_WALK: "res://Assets/Cursors/cursor2.png", #1
#	CURSOR_TALK: "res://Assets/Cursors/cursor3.png", #2
#}
#var current_cursor = 0
#var cursors_res = {}
var item_cursor = false

func _ready():
	default_cursor = load("res://Assets/Cursors/cursor1.png")

	reset_cursor()
	
func _process(delta):
	if Input.is_action_just_released("ui_pause"):
		reset_cursor()

func reset_cursor():
		Input.set_custom_mouse_cursor(default_cursor)
		item_cursor = false
		
func change_cursor(item: String):
	var cursor = load("res://Assets/Cursors/" + item + ".png")
	
	if cursor != null:
		Input.set_custom_mouse_cursor(cursor)
		
		item_cursor = true
