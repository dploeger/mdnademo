extends Node2D


func _ready():
	pass





func _on_Hotspot2_pressed():
	Boombox.play_effect(preload("res://sounds/man/man_bedroom_drawer_op.ogg"))
	MdnaCore.change_scene("res://scenes/man/man06b_cl1_op.tscn")