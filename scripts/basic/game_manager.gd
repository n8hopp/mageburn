extends Node

signal game_paused
signal level_up
signal boss_dead

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		game_paused.emit()
	if event.is_action_pressed("placeholder_levelup"):
		if PlayerVariables.nux_mode == true:
			PlayerVariables.current_experience = PlayerVariables.experience_to_level
			level_up.emit()
			
func _ready():
	SilentWolf.configure({
	"api_key": "xV0qSrPBrt5x59MB9ND31avop9WbjxfO4t9uIt1i",
	"game_id": "Mageburn",
	"log_level": 1
	})

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/ui/startscreen.tscn"
	})
	

