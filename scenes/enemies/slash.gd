extends StateMachineState

func on_physics_process(delta):
	state_machine.animation_player.play("attack2")
	
func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "attack2":
		state_machine.change_state("Path")
