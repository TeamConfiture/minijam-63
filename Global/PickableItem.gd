extends Area2D

export(int) var my_step_left = -1
export(int) var my_step_right = -1

func _on_PickableItem_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			Inventory._on_add_inventory_item(name)
			if my_step_left >= 0:
				Tasks.action(my_step_left)
			self.queue_free()
		if event.button_index == BUTTON_RIGHT and my_step_right >= 0:
			Tasks.action(my_step_right)
