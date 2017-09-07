extends Node2D

var joints = [] #convenience var to quickly see all joints (points where parts can overlap

var pressed = false
var following_cursor = false

func _ready():
	set_process_input(true)
	set_process(true)
	get_node("Area2D").connect("input_event", self, "clicked")
	for node in get_node("Area2D/Polygon2D").get_children():
		if node.get_type() == "Position2D":
			joints.append(node)
	pass
	
func _process(delta):
	if following_cursor:
		set_global_pos(get_viewport().get_mouse_pos())

func _input(event):
	if following_cursor:
		if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT:
			following_cursor = false #disable drag+drop when something else is clicked
		elif event.is_action_pressed("ui_left"):
			set_rotd(get_rotd() + 45)
		elif event.is_action_pressed("ui_right"):
			set_rotd(get_rotd() - 45)
	

func clicked(viewport,event,shape_idx):    
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed:
		following_cursor = true