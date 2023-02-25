extends Node2D

signal slash_projectile_fired(_weapon_data)
signal bankai_activated(_weapon_data)


export(PackedScene) var katana_weapon_fire_scene

export (NodePath) var rate_of_fire_timer_path:NodePath
onready var rate_of_fire_timer:Timer= get_node(rate_of_fire_timer_path)

export (NodePath) var slash_audio_delay_path:NodePath
onready var slash_audio_delay:Timer= get_node(slash_audio_delay_path)

export (NodePath) var katana_slash_audio_path:NodePath
onready var katana_slash_audio:AudioStreamPlayer2D= get_node(katana_slash_audio_path)

export (NodePath) var bankai_audio_path:NodePath
onready var bankai_audio:AudioStreamPlayer2D= get_node(bankai_audio_path)



var weapon:Dictionary = {}

func start(_weapon:Dictionary)->void:
	weapon = _weapon
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)

func draw_weapon()->void:
	rate_of_fire_timer.start(weapon.level_details[weapon.level-1].rate_of_fire)
	var _weapon_fire = katana_weapon_fire_scene.instance()
	_weapon_fire.connect("slash_projectile_fired",self,"_on_KatanaWeaponFire_slash_projectile_fired",[],CONNECT_DEFERRED)
	_weapon_fire.connect("bankai_activated",self,"_on_KatanaWeaponFire_bankai_activated",[],CONNECT_DEFERRED)
	add_child(_weapon_fire)
	_weapon_fire.start(weapon)
	slash_audio_delay.start(0.5)


func _on_RateOfFireTimer_timeout():
	draw_weapon()


func _on_SlashAudioDelay_timeout():
	if weapon.level != 5:
		katana_slash_audio.play()
	else:
		bankai_audio.play()

func _on_KatanaWeaponFire_slash_projectile_fired()->void:
	emit_signal("slash_projectile_fired", weapon)

func _on_KatanaWeaponFire_bankai_activated()->void:
	emit_signal("bankai_activated",weapon)