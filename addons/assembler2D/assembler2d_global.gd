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
		if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT:
			dragged_part.connect_joints()
			dragged_part = null
		elif event.is_action_pressed("ui_left"):
			var rot = _round_to(dragged_part.get_rotd(), 45)
			dragged_part.set_rotd(rot)
		elif event.is_action_pressed("ui_right"):
			var rot = _round_to(dragged_part.get_rotd(), -45)
			dragged_part.set_rotd(rot)

func _round_to(val, div):
	val = abs(int(val))
	val -= val % abs((div))
	return val + div
	