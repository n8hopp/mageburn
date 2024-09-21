extends StateMachineState
@export var parent : CharacterBody2D

func on_physics_process(delta):
	state_machine.animation_player.play("hurt")
	
	parent.velocity = parent.knockback
	parent.move_and_slide()
	
	parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
	
func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "hurt":
		state_machine.change_state("BoarRiderPath")
