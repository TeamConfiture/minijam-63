extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Pickable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		Inventory._on_add_inventory_item(name)
		self.queue_free()
