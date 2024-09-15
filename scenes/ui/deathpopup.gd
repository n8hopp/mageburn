extends PanelContainer


# Called when the node enters the scene tree for the first time.




func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_try_again_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/CharacterSelect.tscn")
	
