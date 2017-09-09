extends Position2D

export(Vector2) var normal = null
export(Vector2) var show_normal_vector = true

func _ready():
	pass

func _draw():
	if normal != null and show_normal_vector:
		draw_line(Vector2(0,0), normal, Color(255, 0, 0), 1)