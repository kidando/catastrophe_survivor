extends KinematicBody2D

signal kunai_thrown(_global_position, _weapon_data)
signal forbidden_scroll_spirit_spawned(_global_position, _weapon_data)
signal katana_slah_projectile_fired(_global_position,_weapon_data, _direction)
signal katana_bankai_activated(_global_position,_weapon_data, _direction)

var velocity:Vector2 = Vector2()
var is_moving:bool = false

export (NodePath) var sprite_path:NodePath
onready var sprite:AnimatedSprite= get_node(sprite_path)

export (NodePath) var soul_cash_pickup_audio_path:NodePath
onready var soul_cash_pickup_audio:AudioStreamPlayer2D= get_node(soul_cash_pickup_audio_path)

export (NodePath) var weapons_container_path:NodePath
onready var weapons_container:Node2D= get_node(weapons_container_path)


func _ready()->void:
	connections_initialized()
	add_weapon(Run.player_defaults.default_weapon)


func _physics_process(delta) -> void:
	move_and_slide(velocity)

func _process(delta) -> void:
	_movement(delta)
	_animations()


func connections_initialized()->void:
	Run.connect("player_weapon_picked",self, "_on_Run_player_weapon_picked")

func _movement(delta)->void:
	velocity = Vector2()
	is_moving = false

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		sprite.flip_h = true
		weapons_container.scale.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		sprite.flip_h = false
		weapons_container.scale.x = 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		is_moving = true
		velocity = velocity.normalized() * Run.player_run.movement_speed

func _animations()->void:
	if is_moving:
		sprite.playing = true
	else:
		sprite.playing = false

func play_sound_soul_cash_pickup()->void:
	soul_cash_pickup_audio.play()


func add_weapon(_weapon:Dictionary)->void:
	var _new_weapon = load(_weapon.scene_path).instance()
	weapons_container.add_child(_new_weapon)
	_new_weapon.start(_weapon)
	match _weapon.name:
		"Katana":
			_new_weapon.connect("slash_projectile_fired",self,"_on_Katana_slash_projectile_fired",[],CONNECT_DEFERRED)
			_new_weapon.connect("bankai_activated",self,"_on_Katana_bankai_activated",[],CONNECT_DEFERRED)
		"Kunai":
			_new_weapon.connect("thrown",self,"_on_Kunai_thrown",[],CONNECT_DEFERRED)
		"Forbidden Scroll":
			_new_weapon.connect("spirit_spawned",self,"_on_ForbiddenScroll_spirit_spawned",[],CONNECT_DEFERRED)


func _on_Run_player_weapon_picked(_weapon:Dictionary)->void:
	pass

func _on_Kunai_thrown(_weapon_data:Dictionary)->void:
	emit_signal("kunai_thrown",global_position, _weapon_data)

func _on_ForbiddenScroll_spirit_spawned(_weapon_data:Dictionary)->void:
	emit_signal("forbidden_scroll_spirit_spawned",global_position, _weapon_data)


func _on_Katana_slash_projectile_fired(_weapon_data:Dictionary)->void:
	emit_signal("katana_slah_projectile_fired",global_position,_weapon_data,sprite.flip_h) 

func _on_Katana_bankai_activated(_weapon_data:Dictionary)->void:
	emit_signal("katana_bankai_activated",global_position,_weapon_data, sprite.flip_h) 