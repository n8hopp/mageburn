extends StateMachineState
# PHASE TWO INITIALIZATION

# Called when the state machine enters this state.
func on_enter():
	state_machine.animation_player.play("phase_two")

func on_animation_finished(_anim_name: StringName) -> void:
	state_machine.change_state("SecondPhasePath")

