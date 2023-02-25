extends Node

var list:Array = [
	{
		"name":"Katana",
		"icon_path":"res://assets/ui/weapon_icons/katana.png",
		"scene_path":"res://scenes/player_weapons/Katana.tscn",
		"level":1,
		"level_details":[
			{
				"description":"Slash enemies in the direction you are facing",
				"rate_of_fire":3,
				"damage_range":Vector2(10,13)
			},
			{
				"description":"Wider slash enemies in the direction you are facing",
				"rate_of_fire":3,
				"damage_range":Vector2(10,13)
			},
			{
				"description":"Wider slash with greater damage",
				"rate_of_fire":3,
				"damage_range":Vector2(15,20)
			},
			{
				"description":"Slash Projectile",
				"rate_of_fire":3,
				"damage_range":Vector2(15,20)
			},
			{
				"description":"Senbonzakura Kageyoshi",
				"rate_of_fire":7,
				"damage_range":Vector2(30,50)
			},
		]
	},

	{
		"name":"Kunai",
		"icon_path":"res://assets/ui/weapon_icons/kunai.png",
		"scene_path":"res://scenes/player_weapons/Kunai.tscn",
		"level":1,
		"level_details":[
			{
				"description":"Throw 2 kunai in random directions",
				"rate_of_fire":2,
				"number_of_projectiles":2,
				"damage_range":Vector2(10,13)
			},
			{
				"description":"Throw 4 kunai in random directions",
				"rate_of_fire":2,
				"number_of_projectiles":4,
				"damage_range":Vector2(10,13)
			},
			{
				"description":"Throw 6 more damaging kunai in random directions",
				"rate_of_fire":2,
				"number_of_projectiles":6,
				"damage_range":Vector2(15,20)
			},
			{
				"description":"Throw 8 kunai in fixed directions",
				"rate_of_fire":2,
				"number_of_projectiles":8,
				"damage_range":Vector2(15,20)
			},
			{
				"description":"Throw 16 kunai in fixed directions",
				"rate_of_fire":2,
				"number_of_projectiles":8,
				"damage_range":Vector2(20,30)
			},
		]
	},
	{
		"name":"Zaraki's Reiatsu",
		"icon_path":"res://assets/ui/weapon_icons/zarakis_reiatsu.png",
		"scene_path":"res://scenes/player_weapons/ZarakisReiatsu.tscn",
		"level":1,
		"level_details":[
			{
				"description":"A Katana",
				"rate_of_fire":0.5,
				"damage_range":Vector2(2,5)
			}
		]
	}

]

func get_weapon_by_name(_weapon_name:String)->Dictionary:
	for _weapon in list:
		if _weapon.name == _weapon_name:
			return _weapon

	return list[0] # all else fails
