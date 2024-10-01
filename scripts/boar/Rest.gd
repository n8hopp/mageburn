extends StateMachineState

func on_physics_process(delta):
	state_machine.animation_player.play("idle")
	
func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "idle":
		state_machine.change_state("Path")


func _on_pause_timer_timeout():
	state_machine.change_state("Path")
