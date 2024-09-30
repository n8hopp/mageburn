extends StateMachineState

func on_physics_process(delta):
	state_machine.animation_player.play("hurt")
	
	state_machine.parent.velocity = state_machine.parent.knockback
	state_machine.parent.move_and_slide()
	
	if state_machine.parent.stunned == true:
		state_machine.parent.knockback = lerp(Vector2.ZERO, Vector2.ZERO, 0.0)
	else:
		state_machine.parent.knockback = lerp(state_machine.parent.knockback, Vector2.ZERO, 0.2)
	
func on_animation_finished(_anim_name: StringName) -> void:
	if state_machine.parent.stunned == true:
		state_machine.change_state("Stun")
	elif _anim_name == "hurt":
		state_machine.change_state("Path")
