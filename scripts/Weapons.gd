extends Node

var list:Array = [
	{
		"name":"Katana",
		"icon_path":"res://assets/ui/weapon_icons/katana.png",
		"scene_path":"res://scenes/player_weapons/Katana.tscn",
		"level":1,
		"level_details":{
			1:{
				"description":"A Katana",
				"rate_of_fire":3,
				"damage_range":Vector2(10,13)
			}
		}
	}
]

func get_weapon_by_name(_weapon_name:String)->Dictionary:
	for _weapon in list:
		if _weapon.name == _weapon_name:
			return _weapon

	return list[0] # all else fails
