tool
extends Position2D


export(float) var normal_angle = 0 setget set_normal_angle

var connected_to = null
onready var in_editor = get_tree().is_editor_hint()

func _ready():
	pass

func _draw():
#	if in_editor:
	var ang = deg2rad(normal_angle)
	var normal = Vector2(cos(ang), sin(ang)) * 1000
	draw_line(Vector2(0,0), normal, Color(255, 0, 0), 1)

func set_normal_angle(val):
	normal_angle = val
	update()