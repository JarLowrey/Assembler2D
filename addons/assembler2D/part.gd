extends Node2D

var joints = [] #convenience var to quickly see all joints (points where parts can overlap

func _ready():
	get_node("Area2D").connect("input_event", self, "draggable_clicked")

	for node in get_node("Area2D/Polygon2D").get_children():
		if node.get_type() == "Position2D":
			joints.append(node)
	pass

func draggable_clicked(viewport,event,shape_idx):
	var was_clicked = event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed
	if get_node("/root/assembler2d_global").dragged_obj == null and was_clicked:
		get_node("/root/assembler2d_global").dragged_obj = self