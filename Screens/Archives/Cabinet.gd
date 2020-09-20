extends MarginContainer

export(String) var user_name = "user42069"
export(String) var broom_name = "john"
export(String) var manager_name = ""

onready var input = $Cabinet/VBoxContainer/LineEdit
onready var error_sound = $Error

func _on_LineEdit_text_entered(new_text):
	input.text = ""
	if new_text.to_lower() == user_name:
		Tasks.action(33)
		self.visible = false
	elif new_text.to_lower() == broom_name:
		Tasks.action(34)
		self.visible = false
	elif new_text.to_lower() == manager_name:
		self.visible = false
		Tasks.action(35)
	else:
		error_sound.play()	
	
func _on_Button_pressed():
	self.visible = false
	input.text = ""
