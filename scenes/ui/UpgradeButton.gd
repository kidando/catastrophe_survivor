extends PanelContainer

export (NodePath) var upgrade_icon_path:NodePath
onready var upgrade_icon:TextureRect= get_node(upgrade_icon_path)

export (NodePath) var upgrade_name_path:NodePath
onready var upgrade_name:Label= get_node(upgrade_name_path)

export (NodePath) var upgrade_description_path:NodePath
onready var upgrade_description:Label= get_node(upgrade_description_path)

export (NodePath) var select_label_path:NodePath
onready var select_label:Label= get_node(select_label_path)

