extends Node

enum {CURSOR_LOOK, CURSOR_WALK, CURSOR_TALK} # 0, 1, 2

var n_cursors = 3
var cursors = {
	CURSOR_LOOK: "res://Assets/Cursors/cursor1.png", #0
	CURSOR_WALK: "res://Assets/Cursors/cursor2.png", #1
	CURSOR_TALK: "res://Assets/Cursors/cursor3.png", #2
}
var current_cursor = 0
var cursors_res = {}

func _ready():
	for cursor in cursors:
		cursors_res[cursor] = load(cursors[cursor])
	Input.set_custom_mouse_cursor(cursors_res[current_cursor])
	
func _process(delta):
	if Input.is_action_just_released("ui_next_cursor"):
		next_cursor()
	if Input.is_action_just_released("ui_previous_cursor"):
		previous_cursor()

func next_cursor():
	current_cursor += 1
	if current_cursor >= 3: #on dépasse le dernier curseur
		current_cursor = 0
	Input.set_custom_mouse_cursor(cursors_res[current_cursor])
	
func previous_cursor():
	current_cursor -= 1
	if current_cursor < 0: #on dépasse le premier curseur
		current_cursor = n_cursors - 1
	Input.set_custom_mouse_cursor(cursors_res[current_cursor])
