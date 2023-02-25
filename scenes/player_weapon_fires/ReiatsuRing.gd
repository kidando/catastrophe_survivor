extends Line2D

var points_default

var agression = 3

func _ready():
	points_default = points

func _process(delta):
	for i in points.size():
		if i != points.size()-1:
			points[i].x = points_default[i].x + Game.rng.randf_range(-agression,agression)
			points[i].y = points_default[i].y + Game.rng.randf_range(-agression,agression)

	points[points.size()-1] = points[0]