extends Node2D


func _ready():
	Speedy.hidden = true
	yield(get_tree().create_timer(7), "timeout")
	EgoVenture.change_scene("res://scenes/man/man13d_lift4.tscn")
	
