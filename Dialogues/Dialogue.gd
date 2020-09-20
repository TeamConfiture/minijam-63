extends VBoxContainer

export(String) var dialogue_file = "res://Assets/Dialogues/sample_dialogue.json"
export(float) var dialogue_speed = 100.0

signal end_dialogue

onready var box_name_left = $NamesMargin/Names/VBoxContainer/NameLeft
onready var name_left = $NamesMargin/Names/VBoxContainer/NameLeft/TextLeft
onready var image_left = $NamesMargin/Names/IL/ImageLeft
onready var box_name_right = $NamesMargin/Names/VBoxContainer2/NameRight
onready var name_right = $NamesMargin/Names/VBoxContainer2/NameRight/TextRight
onready var image_right = $NamesMargin/Names/IR/ImageRight
onready var main_text = $TextMargin/MainText/MarginContainer/TextZone

onready var keyboard_sound = $Keyboard

var lines
var line = 0
var current_line
var n_displayed_char = 0.0

var start_dialogue = false

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	self.visible = false
	main_text.visible_characters = 0

func _process(delta):
	if start_dialogue:
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
					emit_signal("end_dialogue")
					queue_free()
					return
				current_line = lines[line]
			set_new_line()

func start_dialogue():
	print(dialogue_file)
	var results = read_json(dialogue_file)
	
	name_left.text = results["nameLeft"]
	name_right.text = results["nameRight"]
	
	load_texture(results["imageLeft"], image_left)
	load_texture(results["imageRight"], image_right)
	
	lines = results["lines"]
	
	current_line = lines[line]
	start_dialogue = true
	self.visible = true
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
			image_left.set_visible(true)
			image_right.set_visible(false)

		"right":
			box_name_left.set_visible(false)
			box_name_right.set_visible(true)
			image_left.set_visible(false)
			image_right.set_visible(true)

		_:
			box_name_left.set_visible(false)
			box_name_right.set_visible(false)
			image_left.set_visible(false)
			image_right.set_visible(false)
	
	keyboard_sound.play(rng.randf_range(0.0, 6.0))

func load_texture(path: String, texture_rect: TextureRect):
	var texture = load(path)
	texture_rect.texture = texture
