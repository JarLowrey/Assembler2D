tool
extends Position2D

onready var in_editor = get_tree().is_editor_hint()

export(Vector2) var normal = null
export(Vector2) var show_normal_vector = true

var connected_to = null

func _ready():
	pass

func _draw():
	if in_editor and normal != null and show_normal_vector:
		draw_line(Vector2(0,0), normal, Color(255, 0, 0), 1)