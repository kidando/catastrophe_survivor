extends Node2D

signal thrown(_weapon_data)

export (NodePath) var rate_of_fire_timer_path:NodePath
onready var rate_of_fire_timer:Timer= get_node(rate_of_fire_timer_path)

export (NodePath) var kunai_throw_audio_path:NodePath
onready var kunai_throw_audio:AudioStreamPlayer2D= get_node(kunai_throw_audio_path)

var weapon:Dictionary = {}

func start(_weapon:Dictionary)->void:
	weapon = _weapon
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)
	


func throw_kunai()->void:
	kunai_throw_audio.play()
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)
	emit_signal("thrown",weapon)

func _on_RateOfFireTimer_timeout():
	throw_kunai()
