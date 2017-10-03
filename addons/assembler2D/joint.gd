tool
extends Position2D


export(Vector2) var normal = Vector2(0,0) setget set_normal

var connected_to = null
onready var in_editor = get_tree().is_editor_hint()

func _ready():
	pass

func _draw():
#	if in_editor:
	var norm = normal * 1000
	draw_line(Vector2(0,0), norm, Color(255, 0, 0), 1)

func set_normal(val):
	normal = val.normalized()
	update()