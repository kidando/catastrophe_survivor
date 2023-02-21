extends Camera2D


export (NodePath) var player_path:NodePath
onready var player:KinematicBody2D= get_node(player_path)

export (NodePath) var level_tilemap_path:NodePath
onready var level_tilemap:TileMap= get_node(level_tilemap_path)


var target = null

func _ready()->void:
	set_target(player)
	_set_boundaries()

func _set_boundaries()->void:
	var _end_pos = level_tilemap.get_used_rect().end
	limit_left = 0
	limit_right = _end_pos.x * level_tilemap.cell_size.x
	limit_top = 0
	limit_bottom = _end_pos.y * level_tilemap.cell_size.y

func set_target(_target)->void:
	target = _target

func _physics_process(delta)->void:
	_follow_target()

func _follow_target()->void:
	if target == null:
		return
	global_position = target.global_position