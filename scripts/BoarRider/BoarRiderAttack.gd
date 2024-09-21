extends StateMachineState

func on_physics_process(delta):
	state_machine.animation_player.play("attack1")
	
func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "attack1":
		state_machine.change_state("BoarRiderPath")
