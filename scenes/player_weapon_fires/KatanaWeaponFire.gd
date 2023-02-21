extends Node2D

signal hit_enemy

export (NodePath) var sprite_path:NodePath
onready var sprite:AnimatedSprite= get_node(sprite_path)

export (NodePath) var weapon_area_path:NodePath
onready var weapon_area:Area2D= get_node(weapon_area_path)

var damage_range:Vector2


func start(_damage_range):
	sprite.frame = 0
	sprite.playing = true
	weapon_area.monitoring = false
	damage_range = _damage_range



func _on_AnimatedSprite_frame_changed():
	if sprite.frame > 3 and sprite.frame < 8:
		weapon_area.monitoring = true
	else:
		weapon_area.monitoring = false


func _on_AnimatedSprite_animation_finished():
	sprite.playing = false
	$DisappearTween.interpolate_property(sprite,"modulate",sprite.modulate,Color(1,1,1,0),1)
	$DisappearTween.start()


func _on_DisappearTween_tween_all_completed():
	queue_free()


func _on_WeaponArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(Game.rng.randi_range(damage_range.x, damage_range.y))
