extends Node

var list:Array = [
	{
		"name":"Shallow Cat",
		"scene_path": "res://scenes/enemies/ShallowCat.tscn",
		"hp":0,
		"movement_speed":50,
		"points":100,
		"soul_level":1,
		"damage_ui_y_position":-85
	}
]


func get_enemy_by_name(_enemy_name:String)->Dictionary:
	for _enemy in list:
		if _enemy.name == _enemy_name:
			return _enemy

	return list[0] # all else fails