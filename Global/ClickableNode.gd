extends Area2D

signal step(step);

export var myStepRight = -1;
export var myStepItem = {"none": -1,"PassHeros": -1,"PassBalayeur": -1,"TenueBalayeur": -1,"Item4": -1,"Item5": -1};

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onArea2Dinputevent( viewport, event, shapeidx ):
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

		# var scene = get_node(".");
		# emit_signal("step", myStep);
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
