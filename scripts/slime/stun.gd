extends StateMachineState

# Called every physics frame when this state is active.
func on_physics_process(delta):
	state_machine.parent.velocity = Vector2.ZERO
	state_machine.parent.move_and_slide()
	
	state_machine.animation_player.play("idle")
