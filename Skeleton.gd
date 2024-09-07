extends CharacterBody2D

@onready var _animation = $AnimationPlayer
@onready var _navagent = $NavigationAgent2D
@onready var _sprite = $Sprite2D

@export var follow_target : CharacterBody2D
@export var hitpoints = 5

@export var movement_speed : float = 30.0
@export var dead = false
var pause_pathfinding = false
var stun_frames = 0
var knockback : Vector2 = Vector2.ZERO

func take_damage():
	if dead:
		return
	
	hitpoints -= 1
	if hitpoints <= 0:
		$SkeletonMachine.change_state("Dead")
		dead = true
		set_collision_layer_value(3, false)
		set_collision_layer_value(1, false)
		z_index = 0
	else:
		# base level hitstun stuff - prob change how we do this later
		$SkeletonMachine.change_state("Hit")

func _ready():
	pass
	
func _physics_process(delta):
	if dead:
		return
	
	#var pathfind_velocity : Vector2 = Vector2.ZERO
	#if !pause_pathfinding:
		#pathfind_velocity = pathfind()
	#
	#velocity = pathfind_velocity + knockback
	#move_and_slide()
	#
	#knockback = lerp(knockback, Vector2.ZERO, 0.1)
	#if pathfind_velocity.x < 0:
		#_sprite.scale.x = -1
	#elif pathfind_velocity.x > 0:
		#_sprite.scale.x = 1
#
	#if velocity.length() > 0:
		#_animation.queue("walk")
	#else:
		#_animation.queue("idle")
#
#func pathfind():
	#_navagent.target_position = follow_target.global_position
	#
	##if we've already gotten to our player, we don't need to anymore
	#if _navagent.is_navigation_finished():
		#return Vector2.ZERO
	#
	#var current_agent_position: Vector2 = global_position
	#var next_path_position: Vector2 = _navagent.get_next_path_position()
	#var velocity_to_next = current_agent_position.direction_to(next_path_position) * movement_speed
	#return velocity_to_next
