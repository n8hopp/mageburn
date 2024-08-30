extends CharacterBody2D

@onready var _animation = $AnimationPlayer
@onready var _navagent = $NavigationAgent2D

@export var follow_target : CharacterBody2D
@export var hitpoints = 5

@export var movement_speed : float = 30.0
@export var dead = false;

func take_damage():
	if dead:
		return
	
	hitpoints -= 1
	if hitpoints <= 0:
		_animation.play("die")
		dead = true
	else:
		_animation.play("hurt")
		_animation.queue("idle")

func _ready():
	pass
	
func _physics_process(delta):
	_navagent.target_position = follow_target.global_position
	
	if _navagent.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = _navagent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

