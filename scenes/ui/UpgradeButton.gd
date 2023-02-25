extends PanelContainer

export (NodePath) var upgrade_icon_path:NodePath
onready var upgrade_icon:TextureRect= get_node(upgrade_icon_path)

export (NodePath) var upgrade_name_path:NodePath
onready var upgrade_name:Label= get_node(upgrade_name_path)

export (NodePath) var upgrade_description_path:NodePath
onready var upgrade_description:Label= get_node(upgrade_description_path)

export (NodePath) var select_label_path:NodePath
onready var select_label:Label= get_node(select_label_path)

var selectd:bool = false

var data:Dictionary

func _ready()->void:
	display_select_label(false)
	

func update_upgarde_icon(_texture:StreamTexture)->void:
	upgrade_icon.texture = _texture

func update_upgrade_name(_item_name:String, _level:int)->void:
	upgrade_name.text = str(_item_name," ", _level)

func update_upgrade_description(_description:String)->void:
	upgrade_description.text = _description

func display_select_label(_enable:bool)->void:
	select_label.visible = _enable

func set_selection(_enable:bool)->void:
	var style_box = get_stylebox("panel")
	if _enable:
		style_box.border_color = Color("fffbc85e")
		select_label.show()
	else:
		style_box.border_color = Color(1,1,1,1)
		select_label.hide()