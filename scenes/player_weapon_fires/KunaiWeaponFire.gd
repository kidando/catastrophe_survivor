extends KinematicBody2D

var data:Dictionary = {}

var move_speed:int = 200

var velocity:Vector2 = Vector2(1,0)

func _ready():
	$LifespanTimer.start(5)


func _physics_process(delta) -> void:
	move_and_slide(velocity)

func _process(delta) -> void:
	_movement(delta)

func _movement(delta)->void:
	velocity = velocity.normalized() * move_speed

func start(_global_position:Vector2, _weapon_data:Dictionary, _direction=null)->void:
	data = _weapon_data
	global_position = _global_position
	
	rotation_degrees = Game.rng.randf_range(0,360)
	if _direction!= null:
		rotation_degrees = _direction
	velocity = velocity.rotated(rotation)


func _on_LifespanTimer_timeout():
	queue_free()


func _on_HurtArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var _damage_range = data['level_details'][data.level-1].damage_range
			body.take_damage(Game.rng.randi_range(_damage_range.x, _damage_range.y))
			queue_free()
