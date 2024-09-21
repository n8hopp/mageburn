extends CharacterBody2D

@onready var _animation = $AnimationPlayer
@onready var _navagent = $NavigationAgent2D
@onready var _sprite = $Sprite2D

@export var follow_target : CharacterBody2D
@export var hitpoints = 10

@export var movement_speed : float = 45.0
@export var dead = false
var pause_pathfinding = false
var stun_frames = 0
var knockback : Vector2 = Vector2.ZERO

var xp_orb_drop = preload("res://scenes/basic_items/xp.tscn")

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
		instance_xp_orb()
	else:
		# base level hitstun stuff - prob change how we do this later
		$SkeletonMachine.change_state("Hit")

func _ready():
	pass

func _physics_process(delta):
	if dead:
		return

func instance_xp_orb():
	var xp_orb = xp_orb_drop.instantiate()
	xp_orb.global_position = global_position
	xp_orb.z_index = 1
	get_tree().current_scene.add_child(xp_orb)

func _on_hitbox_body_entered(body):
	if body.is_in_group("player_hurtbox"):
		body.take_hit(1)
