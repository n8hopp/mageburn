extends Node

signal game_paused
signal level_up

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		game_paused.emit()
	if event.is_action_pressed("placeholder_levelup"):
		level_up.emit()
	

