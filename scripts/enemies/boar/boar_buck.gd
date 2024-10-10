extends StateMachineState

func on_physics_process(delta):
	state_machine.animation_player.play("buck")
	
func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "buck":
		$"../../ChargeTimer".start()
		$"../Path".chargeable = false
		state_machine.change_state("Path")
		
