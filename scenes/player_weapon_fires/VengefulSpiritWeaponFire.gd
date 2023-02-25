extends Area2D

export (NodePath) var shrink_tween_path:NodePath
onready var shrink_tween:Tween= get_node(shrink_tween_path)

export (NodePath) var lifetime_timer_path:NodePath
onready var lifetime_timer:Timer= get_node(lifetime_timer_path)

var data:Dictionary = {

}

func start( _weapon_data:Dictionary)->void:
	lifetime_timer.start(2)
	data = _weapon_data

func _process(delta):
	position.x += 0.5

func _on_ShrinkTween_tween_all_completed():
	queue_free()

func _on_LifetimeTimer_timeout():
	print("I work")
	shrink_tween.interpolate_property(self,"scale",scale,Vector2(0,0),1)
	shrink_tween.start()


func _on_VengefulSpiritWeaponFire_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var _damage_range = data['level_details'][data.level-1].damage_range
			body.take_damage(Game.rng.randi_range(_damage_range.x, _damage_range.y))
