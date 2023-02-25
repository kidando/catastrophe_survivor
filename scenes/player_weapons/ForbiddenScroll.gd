extends Node2D

signal spirit_spawned(_weapon_data)

export (NodePath) var rate_of_fire_timer_path:NodePath
onready var rate_of_fire_timer:Timer= get_node(rate_of_fire_timer_path)

export (NodePath) var sprit_spawned_audio_path:NodePath
onready var sprit_spawned_audio:AudioStreamPlayer2D= get_node(sprit_spawned_audio_path)

var weapon:Dictionary = {}

func start(_weapon:Dictionary)->void:
	weapon = _weapon
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)

func spawn_spirit()->void:
	sprit_spawned_audio.play()
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)
	emit_signal("spirit_spawned",weapon)

func _on_RateOfFireTimer_timeout():
	spawn_spirit()
