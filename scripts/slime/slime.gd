extends CharacterBody2D

@onready var _animation = $AnimationPlayer
@onready var _navagent = $NavigationAgent2D
@onready var _sprite = $Sprite2D

@export var follow_target : CharacterBody2D
@export var hitpoints = 4
@export var level = 2

@export var movement_speed : float = 15.0
@export var dead = false
var pause_pathfinding = false
var stun_frames = 0
var knockback : Vector2 = Vector2.ZERO

var xp_orb_drop = preload("res://scenes/basic_items/xp.tscn")
var child_slime1 = preload("res://scenes/enemies/slime.tscn")
var child_slime2 = preload("res://scenes/enemies/slime.tscn")

func _ready():
	scale.x = (0.5*level) + 0.25
	scale.y = (0.5*level) + 0.25
	hitpoints = (0.5*level)*4 + 1

func take_damage(num):
	if dead:
		return
	
	#TODO: remove; only for testing damage purposes
	num = 1
	
	hitpoints -= num
	if hitpoints <= 0:
		$SlimeMachine.change_state("Dead")
		dead = true
		set_collision_layer_value(3, false)
		set_collision_layer_value(1, false)
		set_collision_layer_value(4, false)
		z_index = 0
	else:
		# base level hitstun stuff - prob change how we do this later
		$SlimeMachine.change_state("Hit")

func _physics_process(delta):
	if dead:
		return

func _on_hitbox_body_entered(body):
	if body.is_in_group("player_hurtbox"):
		body.get_parent().take_hit(1)

func instance_child_slimes():	
	var child1 = child_slime1.instantiate()
	child1.global_position = global_position
	child1.global_position.x -= randf_range(-5, 5)
	child1.global_position.y += 2
	child1.level = level -1
	child1.follow_target = follow_target
	get_tree().current_scene.add_child(child1)
	
	var child2 = child_slime2.instantiate()
	child2.global_position = global_position
	child2.global_position.x += randf_range(-5, 5)
	child2.global_position.y += 2
	child2.level = level -1
	child2.follow_target = follow_target
	get_tree().current_scene.add_child(child2)
	
	queue_free()

func instance_xp_orb():
	var xp_orb = xp_orb_drop.instantiate()
	xp_orb.global_position = global_position
	xp_orb.z_index = 1
	get_tree().current_scene.add_child(xp_orb)
