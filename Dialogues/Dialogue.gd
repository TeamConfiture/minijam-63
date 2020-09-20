extends VBoxContainer

export(String) var dialogue_file = "res://Assets/Dialogues/sample_dialogue.json"
export(float) var dialogue_speed = 100.0

onready var box_name_left = $NamesMargin/Names/NameLeft
onready var name_left = $NamesMargin/Names/NameLeft/TextLeft
onready var box_name_right = $NamesMargin/Names/NameRight
onready var name_right = $NamesMargin/Names/NameRight/TextRight
onready var main_text = $TextMargin/MainText/MarginContainer/TextZone

onready var keyboard_sound = $Keyboard

var lines
var line = 0
var current_line
var n_displayed_char = 0.0

func _ready():
	main_text.visible_characters = 0
	
	var results = read_json(dialogue_file)
	
	name_left.text = results["nameLeft"]
	name_right.text = results["nameRight"]
	lines = results["lines"]
	
	current_line = lines[line]
	set_new_line()


func _process(delta):	
	n_displayed_char += delta * dialogue_speed
	main_text.visible_characters = int(n_displayed_char)
	if n_displayed_char > current_line["line"].length():
		keyboard_sound.stop()
	
	if Input.is_action_pressed("ui_accept"):
		n_displayed_char += delta * dialogue_speed
	
	if Input.is_action_just_pressed("ui_accept"):
		if n_displayed_char >= current_line["line"].length():
			n_displayed_char = 0.0
			line += 1
			if line >= lines.size():
				queue_free()
				return
			current_line = lines[line]
		set_new_line()


func read_json(path):
	var file = File.new()
	
	file.open(path, File.READ)
	var raw_json = file.get_as_text()
	file.close()
	
	var json_result = JSON.parse(raw_json)
	var results
	if json_result.error == OK:
		results = json_result.result
	else:
		push_error("JSON parsing failed.")
	return results


func set_new_line():
	main_text.text = current_line["line"]
	
	match current_line["side"]:
		"left":
			box_name_left.set_visible(true)
			box_name_right.set_visible(false)

		"right":
			box_name_left.set_visible(false)
			box_name_right.set_visible(true)

		_:
			box_name_left.set_visible(false)
			box_name_right.set_visible(false)
	
	keyboard_sound.play()
