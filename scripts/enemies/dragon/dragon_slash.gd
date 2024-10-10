extends StateMachineState

# if player still in slash sensor
var player_found : bool

@onready var slash_sensor = $"../../Sprite2D/SlashSensor"

func on_enter():
	# if we want to make it faster / more difficult
	state_machine.animation_player.speed_scale = 1
	state_machine.animation_player.play("attack2")
	print("test")
	
func on_exit():
	state_machine.animation_player.speed_scale = 1
	
func on_animation_finished(_anim_name: StringName) -> void:
	player_found = false
	if _anim_name == "attack2":
		state_machine.animation_player.speed_scale = 2
		state_machine.animation_player.play("eeby")
	
	if _anim_name == "eeby":
		state_machine.animation_player.speed_scale = 1
		for body in slash_sensor.get_overlapping_bodies():
			if body.is_in_group("player_hurtbox"):
				player_found = true
		
		if !player_found:
			state_machine.change_state("SecondPhasePath")
		else:
			state_machine.animation_player.play("attack2")
