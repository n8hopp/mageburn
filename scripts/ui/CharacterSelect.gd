extends PanelContainer


func _on_paladin_button_pressed():
	PlayerVariables.selected_class = "Paladin"
	get_tree().change_scene_to_file("res://scenes/level/PaladinHellMode.tscn")


func _on_ranger_button_pressed():
	PlayerVariables.selected_class = "Archer"
	get_tree().change_scene_to_file("res://scenes/level/ArcherTestLevel.tscn")
