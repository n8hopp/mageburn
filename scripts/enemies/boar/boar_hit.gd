extends StateMachineState
@export var parent : CharacterBody2D

func on_physics_process(delta):
	state_machine.animation_player.play("hurt")
	
	parent.velocity = parent.knockback
	parent.move_and_slide()
	
	if parent.stunned == true:
		# No knockback if the enemy is trapped
		parent.knockback = lerp(Vector2.ZERO, Vector2.ZERO, 0.0)
	else:
		parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
	
func on_animation_finished(_anim_name: StringName) -> void:
	# If the enemy is currently stunned we don't want to unstun them until the timer is off.
	if parent.stunned == true:
		state_machine.change_state("Stun")
	elif _anim_name == "hurt":
		state_machine.change_state("Path")
