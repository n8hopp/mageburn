extends StateMachineState

# Called every physics frame when this state is active.
func on_physics_process(delta):
	get_parent().get_parent().velocity = Vector2.ZERO
	get_parent().get_parent().move_and_slide()
	
	state_machine.animation_player.play("idle")
