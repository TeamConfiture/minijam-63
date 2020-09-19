extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
var mouse_over = false
var picking = false
var picked = false
var timer = 5
var angle = PI/2.0
var center = Vector2()

func reset():
	picking = false
	angle= PI/2.0
	timer = 5
	position.x = center.x + 150 * cos(angle)
	position.y = center.y + 150 * sin(angle)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	center.x = screen_size.x / 2
	center.y = screen_size.y / 2
	
	reset()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picking:
		angle += (PI/2.5)*delta
		position.x = center.x + 150 * cos(angle)
		position.y = center.y + 150 * sin(angle)
		
		timer -= delta
		
		if timer < 0:
			picked = true
			print_debug ("success!");
			reset()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and mouse_over and not picking:
		picking = true



func _on_Area2D_mouse_entered():
	mouse_over = true


func _on_Area2D_mouse_exited():
	mouse_over = false # Replace with function body.
	reset()
