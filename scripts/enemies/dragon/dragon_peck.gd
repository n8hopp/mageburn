extends StateMachineState

# if player still in peck sensor, 
var player_found : bool

@onready var peck_sensor = $"../../Sprite2D/PeckSensor"


func on_physics_process(delta):
	state_machine.animation_player.play("attack1")
	
func on_animation_finished(_anim_name: StringName) -> void:
	player_found = false
	if _anim_name == "attack1":
		for body in peck_sensor.get_overlapping_bodies():
			if body.is_in_group("player_hurtbox"):
				player_found = true
		
		if !player_found:
			state_machine.change_state("FirstPhasePath")
		
