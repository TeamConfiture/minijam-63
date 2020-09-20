extends ColorRect

export(String) var user_name = ""
export(String) var broom_name = ""
export(String) var manager_name = ""

onready var input = $VBoxContainer/LineEdit
onready var error_sound = $Error

func _on_LineEdit_text_entered(new_text):
	self.visible = false
	if new_text.to_lower() == user_name:
		Tasks.action(33)
	elif new_text.to_lower() == broom_name:
		Tasks.action(34)
	elif new_text.to_lower() == manager_name:
		Tasks.action(35)
	else:
		self.visible = true
		error_sound.play()
	input.text = ""
	


func _on_Button_pressed():
	self.visible = false
	input.text = ""
