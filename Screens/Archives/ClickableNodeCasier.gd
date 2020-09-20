extends "res://Global/ClickableNode.gd"

export(String) var mc_name = ""
export(String) var broom_name = ""
export(String) var manager_name = ""

func onArea2Dinputevent(_viewport, event, _shapeidx):
	var oldItem = "none"
	if (event is InputEventMouseButton and event.pressed): # En cas de clic
		if (event.button_index == BUTTON_LEFT): # Clic gauche
			if Inventory.current_item in myStepItem: # Si on a un item en main, ou rien
				oldItem = Inventory.current_item # On stoque l'item qqpart
				Inventory.current_item = "none" # On le déséquipe (anti bug-exploit)
				if (myStepItem[oldItem] >= 0): # Si il y a une action associée à cet item
					Tasks.action(myStepItem[oldItem]) # On applique l'action
				return # Quoi qu'il arrive, il n'y a rien d'autre de possible
		if (event.button_index == BUTTON_RIGHT): # Clic droit
			if (myStepRight >= 0): # S'il y a une action associée
				Tasks.action(myStepRight); # On applique l'action du clic droit
