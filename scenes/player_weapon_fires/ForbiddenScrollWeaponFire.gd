extends KinematicBody2D

var data:Dictionary = {}

var move_speed:int = 50

var velocity:Vector2 = Vector2(1,0)

var target = null

func _ready():
	$LifetimeTimer.start(5)


func _physics_process(delta) -> void:
	move_and_slide(velocity)

func _process(delta) -> void:
	_movement(delta)

	if target!= null:
		var _vec_target = target.global_position - global_position
		velocity = velocity.rotated(_vec_target.angle())

func _movement(delta)->void:
	velocity = velocity.normalized() * move_speed

func start(_global_position:Vector2, _weapon_data:Dictionary, _target)->void:
	data = _weapon_data
	global_position = _global_position
	target = _target
	if target == null:
		velocity = velocity.rotated(Game.rng.randf_range(0,360))


func _on_HurtArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var _damage_range = data['level_details'][data.level-1].damage_range
			body.take_damage(Game.rng.randi_range(_damage_range.x, _damage_range.y))
			queue_free()

func _on_LifetimeTimer_timeout():
	queue_free()
