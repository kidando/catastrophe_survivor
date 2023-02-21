extends Node

var enabled:bool = true

func _process(delta):
	debug_input()
	
func debug_input()->void:
	if !enabled:
		return
		
	if Input.is_action_pressed("debug_restart"):
		get_tree().reload_current_scene()
		Run.reset_run()
		
	if Input.is_action_pressed("debug_quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("debug_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen