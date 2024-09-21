extends StateMachineState

func on_enter():
	state_machine.animation_player.play("die")
	
	if state_machine.parent.level == 1:
		state_machine.parent.instance_xp_orb()
	else:
		state_machine.parent.instance_child_slimes()
