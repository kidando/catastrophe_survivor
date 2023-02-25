extends Node

export (NodePath) var player_weapon_fires_layer_path:NodePath
onready var player_weapon_fires_layer:Node2D= get_node(player_weapon_fires_layer_path)

export (NodePath) var enemies_layer_path:NodePath
onready var enemies_layer:YSort= get_node(enemies_layer_path)

export (NodePath) var player_path:NodePath
onready var player:KinematicBody2D= get_node(player_path)

export(PackedScene) var kunai_weapon_fire_scene

export(PackedScene) var forbidden_scroll_weapon_fire_scene

export(PackedScene) var katana_slash_projectile_scene

export(PackedScene) var bankai_slash


func _on_Kunai_timeout(_timer:Timer,_global_position, _weapon_data)->void:
	var _directions = [0,45,90,135,180,225,270,315]
	for _direction in _directions:
		var _kunai = kunai_weapon_fire_scene.instance()
		player_weapon_fires_layer.add_child(_kunai)
		_kunai.start(_global_position, _weapon_data, _direction)
	_timer.queue_free()

func _on_Player_kunai_thrown(_global_position:Vector2, _weapon_data:Dictionary):
	var _number_of_projectiles = _weapon_data['level_details'][_weapon_data.level-1].number_of_projectiles
	match _weapon_data.level:
		4:
			var _directions = [0,45,90,135,180,225,270,315]
			for _direction in _directions:
				var _kunai = kunai_weapon_fire_scene.instance()
				player_weapon_fires_layer.add_child(_kunai)
				_kunai.start(_global_position, _weapon_data, _direction)
		5:
			var _directions = [0,45,90,135,180,225,270,315]
			var _timer = Timer.new()
			_timer.connect("timeout",self,"_on_Kunai_timeout",[_timer, _global_position, _weapon_data],CONNECT_DEFERRED)
			add_child(_timer)
			_timer.start((_weapon_data["level_details"][_weapon_data.level-1].rate_of_fire)/2)
			for _direction in _directions:
				var _kunai = kunai_weapon_fire_scene.instance()
				player_weapon_fires_layer.add_child(_kunai)
				_kunai.start(_global_position, _weapon_data, _direction)
		_:
			for _projectile in _number_of_projectiles:
				var _kunai = kunai_weapon_fire_scene.instance()
				player_weapon_fires_layer.add_child(_kunai)
				_kunai.start(_global_position, _weapon_data)


func _on_Player_forbidden_scroll_spirit_spawned(_global_position:Vector2, _weapon_data:Dictionary):
	var _number_of_projectiles = _weapon_data['level_details'][_weapon_data.level-1].number_of_projectiles
	var _i = 0
	for _projectile in _number_of_projectiles:
		var _spirit = forbidden_scroll_weapon_fire_scene.instance()
		player_weapon_fires_layer.add_child(_spirit)
		var _target = null
		if enemies_layer.get_child_count() > 0:
			if enemies_layer.get_child(_i) != null:
				_target = enemies_layer.get_child(_i)
		_spirit.start(_global_position, _weapon_data, _target)


func _on_Player_katana_slah_projectile_fired(_global_position:Vector2, _weapon_data:Dictionary, _direction:bool):
	var _slash = katana_slash_projectile_scene.instance()
	player_weapon_fires_layer.add_child(_slash)
	_slash.global_position = _global_position
	_slash.start(_direction,_weapon_data)


func _on_Player_katana_bankai_activated(_global_position:Vector2, _weapon_data:Dictionary, _direction:bool):
	var _slash = bankai_slash.instance()
	player_weapon_fires_layer.add_child(_slash)
	_slash.global_position = _global_position
	_slash.start(_direction,_weapon_data)