extends Node

export (NodePath) var hud_path:NodePath
onready var hud:CanvasLayer= get_node(hud_path)

export (NodePath) var run_countdown_ticker_path:NodePath
onready var run_countdown_ticker:Timer= get_node(run_countdown_ticker_path)

func _ready()->void:
    run_countdown_ticker.start(1)


func _on_RunCountdownTicker_timeout():
    Run.tick_timer_down()
    hud.update_timer()
    run_countdown_ticker.start(1)
