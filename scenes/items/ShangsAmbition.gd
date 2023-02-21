extends Node2D


func _ready():
	pass


func _on_AttractionArea_area_entered(area:Area2D):
	if area.has_method("influence_attraction"):
		area.influence_attraction()
