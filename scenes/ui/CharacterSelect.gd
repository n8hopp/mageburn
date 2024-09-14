extends Node2D


# Called when the node enters the scene tree for the first time.

func _on_paladin_class_button_pressed():
	#character = "Paladin"
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")


func _on_ranger_class_button_pressed():
	#character = "Ranger"
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")
