extends CanvasLayer

export (NodePath) var level_label_path:NodePath
onready var level_label:Label= get_node(level_label_path)

export (NodePath) var xp_progress_path:NodePath
onready var xp_progress:ProgressBar= get_node(xp_progress_path)

export (NodePath) var score_label_path:NodePath
onready var score_label:Label= get_node(score_label_path)

export (NodePath) var time_label_path:NodePath
onready var time_label:Label= get_node(time_label_path)

export (NodePath) var debug_label_path:NodePath
onready var debug_label:Label= get_node(debug_label_path)

export (NodePath) var weapon_icon_container_path:NodePath
onready var weapon_icon_container:HBoxContainer= get_node(weapon_icon_container_path)

export (NodePath) var vanquised_label_path:NodePath
onready var vanquised_label:Label= get_node(vanquised_label_path)

func _ready()->void:
	update_level()
	update_xp_progress()
	update_score()
	connections_initialized()
	display_debug_label(Debug.enabled)
	add_weapon(Run.player_run.default_weapon.icon_path)
	update_timer()
	update_vanquished()

func connections_initialized()->void:
	Run.connect("player_xp_updated",self, "_on_Run_player_xp_updated")
	Run.connect("player_level_updated",self, "_on_Run_player_level_updated")
	Run.connect("player_weapon_picked",self, "_on_Run_player_weapon_picked")
	Run.connect("player_points_updated",self, "_on_Run_player_points_updated")
	Run.connect("enemy_vanquished",self, "_on_Run_enemy_vanquished")


func update_vanquished()->void:
	vanquised_label.text = str("VANQUISHED ", Run.enemy_run.vanquished.size())

func update_level()->void:
	level_label.text = str("LEVEL ",Run.player_run.level)

func update_xp_progress()->void:
	xp_progress.value = Run.player_run.xp
	xp_progress.max_value = Run.player_run.xp_max

func update_score()->void:
	score_label.text = str("SCORE ",Run.player_run.score)

func update_timer()->void:
	var _minutes = str(Run.level_run.time_left.x)
	var _seconds = str(Run.level_run.time_left.y)

	if Run.level_run.time_left.x < 10:
		_minutes = str("0",Run.level_run.time_left.x)

	if Run.level_run.time_left.y < 10:
		_seconds = str("0",Run.level_run.time_left.y)

	time_label.text = str("TIME ",_minutes,":",_seconds)


func _on_Run_player_xp_updated()->void:
	update_xp_progress()

func _on_Run_player_level_updated()->void:
	update_level()

func _on_Run_player_weapon_picked(_weapon:Dictionary)->void:
	add_weapon(_weapon.icon_path)

func _on_Run_player_points_updated()->void:
	update_score()

func _on_Run_enemy_vanquished()->void:
	update_vanquished()

func display_debug_label(_enable:bool)->void:
	debug_label.visible	= _enable

func add_weapon(_texture_path:String)->void:
	var _texture_rect:TextureRect = TextureRect.new()
	_texture_rect.texture = load(_texture_path)
	weapon_icon_container.add_child(_texture_rect)
