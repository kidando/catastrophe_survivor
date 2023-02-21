extends Node2D



export(PackedScene) var katana_weapon_fire_scene

export (NodePath) var rate_of_fire_timer_path:NodePath
onready var rate_of_fire_timer:Timer= get_node(rate_of_fire_timer_path)

export (NodePath) var slash_audio_delay_path:NodePath
onready var slash_audio_delay:Timer= get_node(slash_audio_delay_path)

export (NodePath) var katana_slash_audio_path:NodePath
onready var katana_slash_audio:AudioStreamPlayer2D= get_node(katana_slash_audio_path)

var weapon:Dictionary = {}

func start(_weapon:Dictionary)->void:
	weapon = _weapon
	rate_of_fire_timer.start(weapon.level_details[weapon.level].rate_of_fire)

func draw_weapon()->void:
	rate_of_fire_timer.start(weapon.level_details[weapon.level].rate_of_fire)
	var _weapon_fire = katana_weapon_fire_scene.instance()
	add_child(_weapon_fire)
	_weapon_fire.start(weapon.level_details[weapon.level].damage_range)
	slash_audio_delay.start(0.5)


func _on_RateOfFireTimer_timeout():
	draw_weapon()


func _on_SlashAudioDelay_timeout():
	katana_slash_audio.play()
