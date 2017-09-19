extends Node2D

func _ready():
	pass
	
func nearest_join(given_joint):
	var dist = 10000
	var nearest_joint  = null
	for part in get_children():
		for joint in part.get_node("Area2D/Polygon2D"):
			var dist_to_new_joint = given_joint.distance_to(joint)
			if dist_to_new_joint < dist:
				dist = dist_to_new_joint
				nearest_joint = joint
	return nearest_joint

func get_parts():
	var parts = []
	for child in get_children():
		parts.append(child)
	return parts