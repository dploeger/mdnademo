extends Node2D

func _ready():
	pass

func _on_Hotspot_activate():
	EgoVenture.target_view = "front"
	EgoVenture.change_scene("res://scenes/man/man17.tscn")
