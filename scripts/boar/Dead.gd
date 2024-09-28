extends StateMachineState

func on_enter():
	state_machine.animation_player.play("die")

