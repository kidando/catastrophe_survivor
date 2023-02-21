extends Node

export (NodePath) var enemies_layer_path:NodePath
onready var enemies_layer:YSort= get_node(enemies_layer_path)

export (NodePath) var player_path:NodePath
onready var player:KinematicBody2D= get_node(player_path)

export (NodePath) var vfx_layer_path:NodePath
onready var vfx_layer:YSort= get_node(vfx_layer_path)

export (NodePath) var pickups_layer_path:NodePath
onready var pickups_layer:YSort= get_node(pickups_layer_path)

export(PackedScene) var impact_scene

export(PackedScene) var soul_cash_scene

func _process(delta)->void:
	debug_enemy_spawning()

func debug_enemy_spawning()->void:
	if !Debug.enabled:
		return
	
	if Input.is_action_just_pressed("debug_spawn_enemy"):
		var _enemy_data = Enemies.list[0]
		var _enemy = load(_enemy_data.scene_path).instance()
		enemies_layer.add_child(_enemy)
		_enemy.connect("hit",self,"_on_Enemy_hit",[],CONNECT_DEFERRED)
		_enemy.connect("died",self,"_on_Enemy_died",[],CONNECT_DEFERRED)
		_enemy.start(_enemy_data, player)
		_enemy.global_position = enemies_layer.get_global_mouse_position()


func _on_Enemy_hit(_global_position:Vector2)->void:
	var _impact = impact_scene.instance()
	vfx_layer.add_child(_impact)
	_impact.global_position = _global_position

func _on_Enemy_died(_global_position:Vector2, _enemy_data:Dictionary)->void:
	Run.update_player_score(_enemy_data.points)
	var _rand_chance = Game.rng.randi_range(0,1)

	if _rand_chance == 1:
		var _soul_cash = soul_cash_scene.instance()
		pickups_layer.add_child(_soul_cash)
		_soul_cash.global_position = _global_position
		_soul_cash.start(_enemy_data.soul_level)
		