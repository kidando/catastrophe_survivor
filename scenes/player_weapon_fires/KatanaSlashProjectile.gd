extends KinematicBody2D

var data:Dictionary = {}
var velocity:Vector2 = Vector2()
var move_speed:int = 200


func start(_direction:bool, _weapon_data:Dictionary)->void:
	data = _weapon_data
	velocity = Vector2(1,0)
	if _direction:
		velocity = Vector2(-1,0)
		scale.x = -1
	velocity = velocity.normalized() * move_speed


func _physics_process(delta) -> void:
	move_and_slide(velocity)


func _on_LifespanTimer_timeout():
	queue_free()


func _on_HurtArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var _damage_range = data['level_details'][data.level-1].damage_range
			body.take_damage(Game.rng.randi_range(_damage_range.x, _damage_range.y))
