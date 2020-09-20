extends MarginContainer

export(String) var login_querry = "Enter your login: "
export(String) var password_querry = "Enter your password: "

export(String) var login_manager = "manager#007"
export(String) var password_manager = "schrodinger"

onready var line_edit = $Control2/LineEdit
onready var screen = $VBoxContainer/Output/TextEdit

onready var startup_sound = $Startup
onready var error_sound = $Error
onready var correct_sound = $Correct

var default_line_edit
var is_loging = true
var login
var password

# Called when the node enters the scene tree for the first time.
func _ready():
	default_line_edit = line_edit.text
	screen.text += login_querry
	startup_sound.play()

func _on_LineEdit_text_changed(new_text):
	if new_text.length() < default_line_edit.length():
		reset_line_edit()

func _on_LineEdit_text_entered(new_text):
	if is_loging:
		login = new_text.substr(2).dedent().to_lower()
		line_edit.secret = true
		line_edit.text = ""
		screen.text += login
		screen.text += "\n"
		screen.text += password_querry
		is_loging = false
	else:
		password = new_text.dedent().to_lower()
		screen.text += "********\n"
		line_edit.secret = false
		is_loging = true
		check_user()
	screen.scroll_vertical = screen.get_line_count()
	reset_line_edit()

func reset_line_edit():
	if is_loging:
		line_edit.text = default_line_edit
		line_edit.caret_position = default_line_edit.length()
	
func check_user():
	if login_manager == login and password_manager == password:
		successful_login()
	else:
		reset_login()
		
func successful_login():
	correct_sound.play()
	screen.text += "--------------------------------------\nCongratulation! This is a sample text.\n--------------------------------------"
	Inventory.changeVisibility(false)
	Bgm.stop()
	Global.goto_scene("res://Global/Outro.tscn")
	

func reset_login():
	error_sound.play()
	screen.text += "***INVALID PASSWORD***"
	screen.text += "\nYour system manager will be informed and you will be *fired*."
	screen.text += "\nPlease try again\n\n"
	screen.text += login_querry


func _on_Button_pressed():
	self.visible = false
