extends MarginContainer

onready var line_edit = $VBoxContainer/Input/LineEdit
onready var screen = $VBoxContainer/Output/TextEdit

var default_line_edit

# Called when the node enters the scene tree for the first time.
func _ready():
	default_line_edit = line_edit.text


func _on_LineEdit_text_changed(new_text):
	if new_text.length() < default_line_edit.length():
		reset_line_edit()

func _on_LineEdit_text_entered(new_text):
	screen.text += new_text
	screen.text += "\n"
	reset_line_edit()
	screen.scroll_vertical = screen.get_line_count()

func reset_line_edit():
	line_edit.text = default_line_edit
	line_edit.caret_position = default_line_edit.length()
