extends Node2D

signal hit_enemy
signal slash_projectile_fired
signal bankai_activated

export (NodePath) var sprite_path:NodePath
onready var sprite:AnimatedSprite= get_node(sprite_path)

export (NodePath) var weapon_area_path:NodePath
onready var weapon_area:Area2D= get_node(weapon_area_path)

var damage_range:Vector2

var weapon:Dictionary = {}
var can_fire_projectile:bool = true

func start(_weapon:Dictionary)->void:
	weapon = _weapon
	sprite.animation = str("level",weapon.level)
	match weapon.level:
		1:
			$WeaponArea/Level1.disabled = false
		2:
			$WeaponArea/Level2.disabled = false
		3:
			$WeaponArea/Level3.disabled = false
		5:
			position.x = position.x + 48 
			position.y = position.y - 32 
	sprite.frame = 0
	sprite.playing = true
	weapon_area.monitoring = false
	var _damage_range = weapon.level_details[weapon.level-1].damage_range
	damage_range = _damage_range



func _on_AnimatedSprite_frame_changed():
	if sprite.frame > 3 and sprite.frame < 8:
		weapon_area.monitoring = true
		if weapon.level == 4:
			if can_fire_projectile:
				can_fire_projectile = false
				emit_signal("slash_projectile_fired")
	else:
		weapon_area.monitoring = false


func _on_AnimatedSprite_animation_finished():
	sprite.playing = false
	if weapon.level == 3:
		sprite.frame = 8
	if weapon.level == 5:
		sprite.frame = 7
	$DisappearTween.interpolate_property(sprite,"modulate",sprite.modulate,Color(1,1,1,0),1)
	$DisappearTween.start()


func _on_DisappearTween_tween_all_completed():
	emit_signal("bankai_activated")
	queue_free()


func _on_WeaponArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(Game.rng.randi_range(damage_range.x, damage_range.y))
