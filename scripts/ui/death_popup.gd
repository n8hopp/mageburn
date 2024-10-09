extends PanelContainer

var shown = false

# Called when the node enters the scene tree for the first time.


func _ready():
	PlayerVariables.death.connect(_toggle_visible)


func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_try_again_button_pressed():
	PlayerVariables.current_health_pool = 10
	PlayerVariables.current_hp = 10
	PlayerVariables.current_experience = 0
	PlayerVariables.level = 1
	# Reset unlocked abilities
	PlayerVariables.k_locked = true
	PlayerVariables.l_locked = true
	# Makes sure that Nux Mode isn't still active
	PlayerVariables.nux_mode = false
	PlayerVariables.experience_to_level = 5
	
	get_tree().change_scene_to_file("res://scenes/ui/character_select.tscn")

func _toggle_visible():
	if shown:
		shown = false
		hide()
	else:
		shown = true
		$Panel/VBoxContainer/LeaderboardSubmit/submitbox.show()
		$Panel/VBoxContainer/LeaderboardSubmit/submitted.hide()
		$Panel/VBoxContainer/HBoxContainer2/levelnum.text = str(PlayerVariables.level)
		show()
		
func _on_submit_score_button_pressed():
	var name = $Panel/VBoxContainer/LeaderboardSubmit/submitbox/LineEdit.text
	if name == "":
		return
	else:
		var score := int($Panel/VBoxContainer/HBoxContainer2/levelnum.text)
		SilentWolf.Scores.save_score(name, score)
		$Panel/VBoxContainer/LeaderboardSubmit/submitbox.hide()
		$Panel/VBoxContainer/LeaderboardSubmit/submitted.show()
