extends Node2D

export(bool) var auto_create_joints = true
var joints = [] #convenience var to quickly see all joints (points where parts can overlap

func _ready():
	get_node("Area2D").connect("input_event", self, "draggable_clicked")

	if auto_create_joints:
		_auto_create_joints()
	else:
		_add_joints_to_inst_var()

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
	print(connections)
	return connections

func connect_joints():
	var nearby_joints = search_for_connections(get_node("/root/assembled"))
	
	if nearby_joints.size() == 0:
		return
		
	var cnct_joints = nearby_joints[0]
	
	#set proper rotation
	var rotd_diff = get_global_rotd() + cnct_joints.mine.get_global_rotd()
	set_global_rotd(cnct_joints.theirs.get_global_rotd())
	
	#set proper position
	var diff_vector = get_global_pos() - cnct_joints.mine.get_global_pos()
	set_global_pos(cnct_joints.theirs.get_global_pos() + diff_vector)
	
	return

func _auto_create_joints():
	var node = get_node("Area2D/CollisionPolygon2D")
	var pos = node.get_global_pos()
	var polygon = node.get_polygon()
	
	var jt_node =  load("res://addons/assembler2D/example/joint.tscn")
	_create_joint(polygon[polygon.size() - 1], polygon[0], jt_node, true)
	for i in range(0, polygon.size() - 1):
		var reverse_normal = i >= polygon.size() / 2
		_create_joint(polygon[i],polygon[i+1], jt_node,reverse_normal)
	_add_joints_to_inst_var()
	

func _add_joints_to_inst_var():
	for node in get_node("Area2D/CollisionPolygon2D").get_children():
		if node.get_type() == "Position2D":
			joints.append(node)

func _create_joint(start_pos, end_pos, joint_node,reverse_normal = false):
	var pos = (start_pos + end_pos) / 2
	var dx = end_pos.x - start_pos.x
	var dy = end_pos.y - start_pos.y
	
	var nd = joint_node.instance()
	get_node("Area2D/CollisionPolygon2D").add_child(nd)
	nd.set_pos(pos)
	var normal = rad2deg(atan(-dx/dy))
	if reverse_normal:
		normal += 180 #ensures normal always points towards outside of polygon
	nd.set_normal_angle( normal )
	
	return nd
