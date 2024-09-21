extends StateMachineState

func on_enter():
	state_machine.animation_player.play("die")

func on_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "die":
		if state_machine.parent.level == 1:
			state_machine.parent.instance_xp_orb()
		else:
			$"../../Timer".start()

func _on_timer_timeout():
	state_machine.parent.instance_child_slimes()
