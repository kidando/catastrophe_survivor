extends Node

signal player_xp_updated
signal player_level_updated
signal player_weapon_picked(_weapon)
signal player_points_updated
signal enemy_vanquished
 
var player_defaults: Dictionary ={
	"hp_max":100,
	"hp":100,
	"movement_speed":100,
	"hp_regen_pc":0.0, # percent
	"hp_regen_rate":10, # per sec,
	"damage_multiplier":0.0, # percent
	"protection_multiplier":0.0, # percent,
	"level":1,
	"xp":0,
	"xp_max":5,
	"score":0,
	"max_weapons":4,
	"default_weapon":Weapons.list[0],
	"weapon_inventory":[]

}
var player_run:Dictionary = {}


var level_defaults:Dictionary = {
	"time_left":Vector2(10,0), # 10min 0sec,
	"difficulty_level":1
}

var level_run:Dictionary = {}

var enemy_defaults:Dictionary = {
	"vanquished":[]
}

var enemy_run:Dictionary = {}

func reset_run()->void:
	player_run = player_defaults
	add_weapon(player_run.default_weapon.name)
	level_run = level_defaults
	enemy_run = enemy_defaults


func _ready()->void:
	reset_run()
	

func add_weapon(_weapon_name:String)->void:
	if player_run.weapon_inventory.size() < player_run.max_weapons:
		var _weapon = Weapons.get_weapon_by_name(_weapon_name)
		player_run.weapon_inventory.append(_weapon)
		emit_signal("player_weapon_picked",_weapon)

func add_vanquised_enemy()->void:
	pass


func level_up()->void:
	player_run.level += 1
	emit_signal("player_level_updated")
	var _xp_balance = player_run.xp - player_run.xp_max
	player_run.xp_max *= player_run.level

	if _xp_balance < player_run.xp_max:
		player_run.xp = _xp_balance
		emit_signal("player_xp_updated")
	else:
		level_up()

func soul_cash_collectd(_xp_collected:int)->void:
	player_run.xp += _xp_collected
	if player_run.xp < player_run.xp_max:
		emit_signal("player_xp_updated")
	else:
		level_up()

func tick_timer_down()->void:
	level_run.time_left.y -= 1
	if level_run.time_left.y < 0:
		level_run.time_left.y = 59
		level_run.time_left.x -= 1

func update_player_score(_points:int)->void:
	player_run.score += _points
	emit_signal("player_points_updated")

func add_vanquished_enemy(_enemy:Dictionary)->void:
	enemy_run.vanquished.append(_enemy)
	emit_signal("enemy_vanquished")