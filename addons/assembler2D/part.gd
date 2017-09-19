extends Node2D

var joints = [] #convenience var to quickly see all joints (points where parts can overlap

func _ready():
	get_node("Area2D").connect("input_event", self, "draggable_clicked")

	for node in get_node("Area2D/Polygon2D").get_children():
		if node.get_type() == "Position2D":
			joints.append(node)

func draggable_clicked(viewport,event,shape_idx):
	var was_clicked = event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed
	if get_node("/root/assembler2d_global").dragged_part == null and was_clicked:
		get_node("/root/assembler2d_global").dragged_part = self

func search_for_connections(assembler):
	var max_d = get_node("/root/assembler2d_global").max_connection_dist
	var connections = []
	#TODO: more efficient way? O(n^3) is pretty slow, esp if this is in _process
	for jt in joints:
		for pt in assembler.get_parts():
			if pt != self:
				for other_jt in pt.joints:
					var dist = jt.get_global_pos().distance_to(other_jt.get_global_pos())
					if dist < max_d:
						connections.append({'mine':jt, 'theirs': other_jt})
	#print(connections)
	return connections

func connect_joints():
	var nearby_joints = search_for_connections(get_node("/root/assembled"))
	
	if nearby_joints.size() == 0:
		return
		
	var cnct_joints = nearby_joints[0]
	var diff = get_global_pos() - cnct_joints.mine.get_global_pos()
	set_global_pos(cnct_joints.theirs.get_global_pos() + diff)
	
	return
	