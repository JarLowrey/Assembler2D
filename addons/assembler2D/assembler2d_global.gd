extends Node

var dragged_obj = null

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	if dragged_obj != null:
		dragged_obj.set_global_pos(get_viewport().get_mouse_pos())

func _input(event):
	if dragged_obj != null:
		dragged_obj.set_global_pos(get_viewport().get_mouse_pos())
		if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT:
			dragged_obj = null
		elif event.is_action_pressed("ui_left"):
			dragged_obj.set_rotd(dragged_obj.get_rotd() + 45)
		elif event.is_action_pressed("ui_right"):
			dragged_obj.set_rotd(dragged_obj.get_rotd() - 45)
