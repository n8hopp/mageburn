extends StateMachineState
@export var parent : CharacterBody2D

func on_physics_process(delta):
	state_machine.animation_player.play("hurt")
	
	parent.velocity = parent.knockback
	parent.move_and_slide()
	
	if parent.stunned == true:
		parent.knockback = lerp(Vector2.ZERO, Vector2.ZERO, 0.0)
	else:
		parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
	
func on_animation_finished(_anim_name: StringName) -> void:
	if parent.stunned == true:
		state_machine.change_state("Stun")
	elif _anim_name == "hurt":
		if !parent.phase_two:
			if parent.hitpoints <= parent.max_hp / 2.0:
				state_machine.change_state("Tantrum")
			else:
				state_machine.change_state("FirstPhasePath")
		else:
			state_machine.change_state("SecondPhasePath")



