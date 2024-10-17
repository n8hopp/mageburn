extends StateMachineState

@export var parent : CharacterBody2D
@export var nav_agent : NavigationAgent2D
@onready var follow_target : CharacterBody2D = PlayerVariables.follow_target
@export var walk_speed : float = 60.0
@onready var slash_sensor = $"../../Sprite2D/SlashSensor"

func on_enter():
	parent.phase_two = true
	for body in slash_sensor.get_overlapping_bodies():
		if body.is_in_group("player_hurtbox"):
			state_machine.change_state("Slash")
	
# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	nav_agent.target_position = follow_target.global_position
	
	var current_agent_position: Vector2 = nav_agent.get_parent().global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	parent.velocity = current_agent_position.direction_to(next_path_position) * walk_speed
	parent.move_and_slide()
	
	if parent.global_position.direction_to(follow_target.global_position).x > 0:
		parent._sprite.scale.x = 1
	elif parent.global_position.direction_to(follow_target.global_position).x < 0:
		parent._sprite.scale.x = -1
		
	state_machine.animation_player.play("walk")


func _on_slash_sensor_body_entered(body):
	if parent.dead or state_machine == null:
		return
	if parent.phase_two and !parent.sleeby:
		if body.is_in_group("player_hurtbox"):
			state_machine.change_state("Slash")
