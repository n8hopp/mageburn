extends StateMachineState

@export var parent : CharacterBody2D
@export var nav_agent : NavigationAgent2D
@onready var follow_target : CharacterBody2D = PlayerVariables.follow_target
@export var walk_speed : float = 35.0
var chargeable = true
# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	nav_agent.target_position = follow_target.global_position
	
	#if we are close to player then start charge
	if nav_agent.distance_to_target() <= 200 and chargeable:
		state_machine.change_state("Charge")
	elif nav_agent.is_navigation_finished():
		state_machine.change_state("Attack")
		
	var current_agent_position: Vector2 = nav_agent.get_parent().global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	parent.velocity = current_agent_position.direction_to(next_path_position) * walk_speed
	parent.move_and_slide()
	
	if parent.global_position.direction_to(follow_target.global_position).x > 0:
		parent._sprite.scale.x = 1
	elif parent.global_position.direction_to(follow_target.global_position).x < 0:
		parent._sprite.scale.x = -1
		
	state_machine.animation_player.play("walk")


func _on_charge_timer_timeout():
	chargeable = true
