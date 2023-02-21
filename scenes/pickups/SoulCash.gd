extends Node2D



export (NodePath) var sprite_path:NodePath
onready var sprite:AnimatedSprite= get_node(sprite_path)

var xp = 1


func start(_soul_level:int):
	var _no_of_frames = sprite.frames.get_frame_count("default")
	sprite.frame = Game.rng.randi_range(0,_no_of_frames-1)

	match _soul_level:
		1:
			xp = 1
			sprite.self_modulate = Color(1,1,1,1)
		2:
			xp = 10
			sprite.self_modulate = Color(0,0,1,1)
		3:
			xp = 25
			sprite.self_modulate = Color(1,0,1,1)
		4:
			xp = 50
			sprite.self_modulate = Color(1,0,0,1)

func _on_PickupArea_body_entered(body:Node):
	if body.is_in_group("players"):
		if body.has_method("play_sound_soul_cash_pickup"):
			body.play_sound_soul_cash_pickup()
		Run.soul_cash_collectd(xp)
		queue_free()
