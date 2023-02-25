extends Node2D


export (NodePath) var hazard_area_path:NodePath
onready var hazard_area:Area2D= get_node(hazard_area_path)

export (NodePath) var hazard_area_monitoring_toggle_timer_path:NodePath
onready var hazard_area_monitoring_toggle_timer:Timer= get_node(hazard_area_monitoring_toggle_timer_path)

var data:Dictionary = {}


func start(_weapon:Dictionary)->void:
	data = _weapon
	var _rof = _weapon['level_details'][_weapon.level-1].rate_of_fire
	hazard_area_monitoring_toggle_timer.start(_rof)

func _on_HazardArea_body_entered(body:Node):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var _damage_range = data['level_details'][data.level-1].damage_range
			body.take_damage(Game.rng.randi_range(_damage_range.x, _damage_range.y))


func _on_HazardAreaMonitorToggleTimer_timeout():
	hazard_area.monitoring = !hazard_area.monitoring
	var _rof = data['level_details'][data.level-1].rate_of_fire
	hazard_area_monitoring_toggle_timer.start(_rof)

