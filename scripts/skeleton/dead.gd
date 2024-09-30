extends StateMachineState



func on_enter():
	state_machine.animation_player.play("die")
	
	var deathtimer = Timer.new()
	add_child(deathtimer)
	deathtimer.timeout.connect(_on_death_timeout)
	deathtimer.wait_time = 30.0
	deathtimer.one_shot = true
	deathtimer.start()
	
func _on_death_timeout():
	state_machine.get_parent().queue_free()

func on_animation_finished(_anim_name: StringName) -> void:
	print("boss dead")
	GameManager.boss_dead.emit()
