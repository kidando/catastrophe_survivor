extends CanvasLayer

export (NodePath) var upgrades_container_path:NodePath
onready var upgrades_container:HBoxContainer= get_node(upgrades_container_path)

export (NodePath) var visibility_tween_path:NodePath
onready var visibility_tween:Tween= get_node(visibility_tween_path)

export (NodePath) var movement_tween_path:NodePath
onready var movement_tween:Tween= get_node(movement_tween_path)

export (NodePath) var main_container_path:NodePath
onready var main_container:MarginContainer= get_node(main_container_path)

export (NodePath) var launch_upgrade_menu_audio_path:NodePath
onready var launch_upgrade_menu_audio:AudioStreamPlayer= get_node(launch_upgrade_menu_audio_path)

export (NodePath) var select_upgrade_audio_path:NodePath
onready var select_upgrade_audio:AudioStreamPlayer= get_node(select_upgrade_audio_path)

export (NodePath) var move_left_right_audio_path:NodePath
onready var move_left_right_audio:AudioStreamPlayer= get_node(move_left_right_audio_path)

export(PackedScene) var upgrade_button_scene

var highlighted_upgrade:int = 0

var is_tweening:bool = false
var is_visible:bool = false
func _ready()->void:
	get_tree().paused = true
	set_selection(highlighted_upgrade)
	tween_in(true)


func init_upgrade_buttons()->void:
	pass
func set_selection(_position:int)->void:
	var _i = 0

	for _upgrade in upgrades_container.get_children():
		if _i == _position:
			_upgrade.set_selection(true)
		else:
			_upgrade.set_selection(false)
		_i += 1

func _process(delta):
	if is_tweening:
		return
	if Input.is_action_just_pressed("upgrade_ui_left"):
		move_left_right_audio.play()
		highlighted_upgrade -= 1
		if highlighted_upgrade < 0:
			highlighted_upgrade = upgrades_container.get_child_count()-1
		set_selection(highlighted_upgrade)

	if Input.is_action_just_pressed("upgrade_ui_right"):
		move_left_right_audio.play()
		highlighted_upgrade += 1
		if highlighted_upgrade > upgrades_container.get_child_count()-1:
			highlighted_upgrade = 0
		set_selection(highlighted_upgrade)

	if Input.is_action_just_pressed("upgrade_ui_accept"):
		select_upgrade_audio.play()
		tween_in(false)
		
func tween_in(_enable:bool)->void:
	var _start_pos:Vector2 = Vector2(0,64)
	var _end_pos:Vector2 = Vector2(0,0)
	var _start_modulate:Color = Color(1,1,1,0)
	var _end_modulate:Color = Color(1,1,1,1)
	var _duration:float = 0.5
	if !_enable:
		_start_pos = Vector2(0,0)
		_end_pos = Vector2(0,64)
		_start_modulate = Color(1,1,1,1)
		_end_modulate = Color(1,1,1,0)
	else:
		launch_upgrade_menu_audio.play()
	visibility_tween.interpolate_property(main_container,"modulate",_start_modulate,_end_modulate,_duration)
	visibility_tween.start()
	movement_tween.interpolate_property(main_container,"rect_position",_start_pos,_end_pos,_duration)
	movement_tween.start()
	is_tweening = true


func _on_VisibilityTween_tween_all_completed():
	is_tweening = false
	is_visible = !is_visible

	if !is_visible:
		get_tree().paused = false
		queue_free()
