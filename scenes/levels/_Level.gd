extends Node

export (NodePath) var hud_path:NodePath
onready var hud:CanvasLayer= get_node(hud_path)

export (NodePath) var run_countdown_ticker_path:NodePath
onready var run_countdown_ticker:Timer= get_node(run_countdown_ticker_path)

export (NodePath) var screen_overlay_layer_path:NodePath
onready var screen_overlay_layer:Node= get_node(screen_overlay_layer_path)

export(PackedScene) var upgrade_menu_scene

func _ready()->void:
    run_countdown_ticker.start(1)
    Run.connect("player_level_updated",self,"_on_Run_player_level_updated")


func _on_RunCountdownTicker_timeout():
    Run.tick_timer_down()
    hud.update_timer()
    run_countdown_ticker.start(1)

func _on_Run_player_level_updated()->void:
    var _upgrade_menu = upgrade_menu_scene.instance()
    screen_overlay_layer.add_child(_upgrade_menu)