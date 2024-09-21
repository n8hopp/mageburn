extends StateMachineState

func on_enter():
	state_machine.animation_player.play("summon")

func on_animation_finished(_anim_name):
	if _anim_name == "summon":
		state_machine.change_state("Path")
