extends Node2D

onready var container = $Inventory/Panel/HBoxContainer
export var current_item = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	#_on_add_inventory_item("Lapignon")
	self.visible = false
	self.hide()


func find_child_by_name(name: String, children :Array):
	for c in children:
		if c.name == name:
			return c
	
	return null
	
func changeVisibility(isVisible: bool):
	if isVisible:
		self.visible = true
		self.show()
	else:
		self.visible = false
		self.hide()

func _process(_delta):
	if Input.is_action_just_released("ui_pause"):
		current_item = "none"
		
# Adds an item to inventory by name
func _on_add_inventory_item(item: String):
	if find_child_by_name(item, container.get_children()) == null:
		var i = load("res://Inventory/Items/"+ item + ".tscn")

		if i == null:
			return false

		container.add_child(i.instance())
		print("We added item ", item)
		return true
	else:
		print("We already have item ", item)
		return false
