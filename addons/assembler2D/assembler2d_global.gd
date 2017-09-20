extends Node

var dragged_part = null
var max_connection_dist = 20


func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	if dragged_part != null:
		dragged_part.set_global_pos(get_viewport().get_mouse_pos())
		dragged_part.search_for_connections(get_node("/root/assembled"))

func _input(event):
	if dragged_part != null:
		dragged_part.set_global_pos(get_viewport().get_mouse_pos())
		
		var left = event.is_action_pressed("ui_left")
		var right = event.is_action_pressed("ui_right")
		var released_mouse = event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT
		
		if released_mouse:
			dragged_part.connect_joints()
			dragged_part = null
		elif left or right:
			var num_45s = int(dragged_part.get_rotd()) / 45
			num_45s += 1 if left else -1
			dragged_part.set_rotd( (num_45s * 45) % 360 )
