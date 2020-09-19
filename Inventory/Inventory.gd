extends MarginContainer

onready var container = $Panel/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Adds an item to inventory by name
func _on_add_inventory_item(item: String):
	var i = load("res://Inventory/Items/"+ item + ".tscn")

	if i == null:
		return false

	container.add_child(i.instance())
	return true



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
