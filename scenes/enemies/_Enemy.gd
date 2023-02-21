extends KinematicBody2D

signal hit(_global_position)
signal died(_global_position, _enemy_data)

export (NodePath) var take_damage_audio_path:NodePath
onready var take_damage_audio:AudioStreamPlayer2D= get_node(take_damage_audio_path)

export (NodePath) var damage_ui_container_path:NodePath
onready var damage_ui_container:CenterContainer= get_node(damage_ui_container_path)

export (NodePath) var damage_label_path:NodePath
onready var damage_label:Label= get_node(damage_label_path)

export (NodePath) var disappear_tween_path:NodePath
onready var disappear_tween:Tween= get_node(disappear_tween_path)

export (NodePath) var disappeart_timer_path:NodePath
onready var disappeart_timer:Timer= get_node(disappeart_timer_path)

export (NodePath) var sprite_path:NodePath
onready var sprite:AnimatedSprite= get_node(sprite_path)

export (NodePath) var disintegration_tween_path:NodePath
onready var disintegration_tween:Tween= get_node(disintegration_tween_path)

export (NodePath) var death_audio_path:NodePath
onready var death_audio:AudioStreamPlayer2D= get_node(death_audio_path)


var player = null

var velocity:Vector2 = Vector2()

var can_move:bool = true

var can_hurt:bool = true

var hp:int = 10
var movement_speed:int = 50

var data:Dictionary

var start_dying:bool = false
var disintegration_visibility:float = 0



func _physics_process(delta) -> void:
	move_and_slide(velocity)


func _process(delta) -> void:
	_movement()
	_animations()


func _animations()->void:
	if can_move:
		sprite.playing = true
	else:
		sprite.playing = false

	sprite.material.set_shader_param("progress",disintegration_visibility)

func _movement()->void:
	velocity = Vector2()
	if player == null:
		return


	if !can_move:
		return

	

	velocity = player.global_position - global_position
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

	velocity = velocity.normalized() * 50


func start(_enemy_data:Dictionary, _player:KinematicBody2D)->void:
	data = _enemy_data
	player = _player
	damage_ui_container.rect_position.y = data.damage_ui_y_position
	damage_label.modulate = Color(1,1,1,0)

func update_damage_label(_damage_amount:int)->void:
	damage_label.text = str(_damage_amount)
	
func disintegrate()->void:
	pass
	
func take_damage(_damage_amount:int)->void:
	if !can_hurt:
		return
	update_damage_label(_damage_amount)	
	emit_signal("hit",global_position)

	hp -= _damage_amount
	if hp > 0:
		take_damage_audio.play()
	else:
		Run.add_vanquished_enemy(data)
		death_audio.play()
		emit_signal("died",global_position, data)
		can_move = false
		start_dying = true
		can_hurt = false
		disintegration_tween.interpolate_property(self,"disintegration_visibility",0,1,3)
		disintegration_tween.start()
		movement_speed = 0


	disappear_tween.stop_all()
	disappeart_timer.start(0.5)

	if _damage_amount > 0 and _damage_amount <= 10:
		damage_label.modulate = Color(1,1,1,1)
	elif _damage_amount > 10 and _damage_amount <= 20:
		damage_label.modulate = Game.colors.light_lime
	elif _damage_amount > 20 and _damage_amount <= 30:
		damage_label.modulate = Game.colors.yellow
	elif _damage_amount > 30 and _damage_amount <= 40:
		damage_label.modulate = Game.colors.orange
	elif _damage_amount > 40 and _damage_amount <= 50:
		damage_label.modulate = Game.colors.red
	elif _damage_amount > 50:
		damage_label.modulate = Game.colors.purple

func _on_DamageDisappearTimer_timeout():
	disappear_tween.interpolate_property(damage_label,"modulate",damage_label.modulate, Color(1,1,1,0),1)
	disappear_tween.start()


func _on_DisintegrationTween_tween_all_completed():
	queue_free()
