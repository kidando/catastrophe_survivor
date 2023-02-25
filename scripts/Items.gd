extends Node
enum Nature {BLESSING, CURSE}
var list:Array = [
	{
		"name":"Shang's Ambition",
		"icon_path":"res://assets/ui/item_icons/shangs_ambition.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"Absorb items near you"
			}
		]
	},
	{
		"name":"Usopp's Swiftness",
		"icon_path":"res://assets/ui/item_icons/usopps_swiftness.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"10% increase in movement speed"
			}
		]
	},
	{
		"name":"Rejection Spell",
		"icon_path":"res://assets/ui/item_icons/rejection_spell.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"Briefly protects you from enemy damage"
			}
		]
	},
	{
		"name":"Medusa's Charm",
		"icon_path":"res://assets/ui/item_icons/medusas_charm.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"Slows down enemy movement"
			}
		]
	},
	{
		"name":"Garou's Determination",
		"icon_path":"res://assets/ui/item_icons/garous_determination.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"10% damage increase"
			}
		]
	},
	{
		"name":"Hogyoku",
		"icon_path":"res://assets/ui/item_icons/hogyoku.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.CURSE,
		"level":1,
		"level_details":[
			{
				"description":"10% increase in number of enemies"
			}
		]
	},
	{
		"name":"Friendly Yuichi",
		"icon_path":"res://assets/ui/item_icons/hogyoku.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.CURSE,
		"level":1,
		"level_details":[
			{
				"description":"Unlucky Phase 1"
			}
		]
	},
	{
		"name":"Pink Devil Fruit",
		"icon_path":"res://assets/ui/item_icons/pink_devil_fruit.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"10% decrease in weapon cooldown"
			}
		]
	},
	{
		"name":"Alucard's Stunners",
		"icon_path":"res://assets/ui/item_icons/alucards_stunners.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.BLESSING,
		"level":1,
		"level_details":[
			{
				"description":"A chance to gain 5% health from vanquished enemy"
			}
		]
	},
	{
		"name":"Causality",
		"icon_path":"res://assets/ui/item_icons/causality.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.CURSE,
		"level":1,
		"level_details":[
			{
				"description":"A chance to gain 5% health from vanquished enemy"
			}
		]
	},
	{
		"name":"Causality",
		"icon_path":"res://assets/ui/item_icons/the_brand.png",
		"scene_path":"",
		"unlocked":true,
		"nature":Nature.CURSE,
		"level":1,
		"level_details":[
			{
				"description":"Summons a tough enemy every so often"
			}
		]
	}
]

func get_item_by_name(_item_name:String)->Dictionary:
	for _item in list:
		if _item.name == _item_name:
			return _item

	return list[0] # all else fails