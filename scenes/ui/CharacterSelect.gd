extends PanelContainer


func _on_paladin_button_pressed():
	#character = "Paladin"
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")


func _on_ranger_button_pressed():
	#character = "Ranger"
	get_tree().change_scene_to_file("res://scenes/level/ArcherTestLevel.tscn")
