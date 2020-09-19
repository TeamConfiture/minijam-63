extends MarginContainer

onready var container = $Panel/HBoxContainer
var current_item = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	#_on_add_inventory_item("Lapignon")
	self.visible = false

func _process(delta):
	if Input.is_action_just_released("ui_pause"):
		current_item = "none"
		
# Adds an item to inventory by name
func _on_add_inventory_item(item: String):
	var i = load("res://Inventory/Items/"+ item + ".tscn")

	if i == null:
		return false

	container.add_child(i.instance())
	
	return true
