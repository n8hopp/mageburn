extends PanelContainer



func _on_paladin_button_pressed():
	PlayerVariables.selected_class = "Paladin"
	get_tree().change_scene_to_file("res://scenes/level/main.tscn")


func _on_ranger_button_pressed():
	PlayerVariables.selected_class = "Archer"
	get_tree().change_scene_to_file("res://scenes/level/main.tscn")


func _on_check_box_toggled(toggled_on):
	if toggled_on == true:
		PlayerVariables.nux_mode = true
	else:
		PlayerVariables.nux_mode = false
