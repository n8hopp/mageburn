extends Node

signal game_paused
signal level_up
signal boss_dead

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		game_paused.emit()
	if event.is_action_pressed("placeholder_levelup"):
		if PlayerVariables.nux_mode == true:
			level_up.emit()
	

