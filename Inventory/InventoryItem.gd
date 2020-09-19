extends TextureRect

export var combinable_with = []
export var consumes = []
export var produces = []

func find_child_by_name(name: String, children :Array):
	for c in children:
		if c.name == name:
			return c
	
	return null

#TODO : nettoyer
func _on_item_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var other = Inventory.current_item
		if other != "none":
			var child = find_child_by_name(other, Inventory.get_child(0).get_child(0).get_children())
			if other in combinable_with and child != null:
				var _id = combinable_with.find(other)
				if consumes[_id]:
					child.queue_free()
				Inventory._on_add_inventory_item(produces[_id])

				self.queue_free()
				
				Cursor.reset_cursor()
				Inventory.current_item = "none"

		else:
			Cursor.change_cursor(name)
			Inventory.current_item = name


