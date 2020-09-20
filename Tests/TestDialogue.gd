extends Control

onready var dialogue = $Dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartDialogue_pressed():
	dialogue.dialogue_file = "res://Assets/Dialogues/sample_dialogue.json"
	dialogue.start_dialogue()


func _on_Dialogue_end_dialogue():
	$EndDIalogue.visible = true
