extends CharacterBody2D

@onready var _animation = $AnimationPlayer
@onready var _navagent = $NavigationAgent2D
@onready var _sprite = $Sprite2D

@export var follow_target : CharacterBody2D
@export var hitpoints = 30

@export var movement_speed : float = 30.0
@export var dead = false
@export var stunned = false
var pause_pathfinding = false
var stun_frames = 0
var knockback : Vector2 = Vector2.ZERO

var xp_orb_drop = preload("res://scenes/basic_items/xp.tscn")
var damage_number = preload("res://scenes/ui/number_popup.tscn")

func take_damage(num):
	if dead:
		return
	
	var damage_result = PlayerVariables.crit_roll(num)
	var damage = damage_result[0]
	var critted = damage_result[1]
	
	hitpoints -= damage
	
	var number_ui = damage_number.instantiate()
	if critted:
		number_ui.numtype = number_ui.NUMTYPE.CRIT
	else:
		number_ui.numtype = number_ui.NUMTYPE.DAMAGE
	number_ui.number = damage
	add_child(number_ui)
	
	if hitpoints <= 0:
		$BoarMachine.change_state("Dead")
		dead = true
		set_collision_layer_value(3, false)
		set_collision_layer_value(1, false)
		set_collision_layer_value(4, false)
		z_index = 0
		instance_xp_orb()
	else:
		# base level hitstun stuff - prob change how we do this later
		$BoarMachine.change_state("Hit")

func get_stunned():
	if dead:
		return
	stunned = true
	$BoarMachine.change_state("Stun")
	$CollisionBox.disabled = true

func get_unstunned():
	if dead:
		return
	stunned = true
	$BoarMachine.change_state("Path")
	$CollisionBox.disabled = false

func _ready():
	pass

func _physics_process(delta):
	if dead || stunned:
		return

func instance_xp_orb():
	var xp_orb = xp_orb_drop.instantiate()
	xp_orb.global_position = global_position
	xp_orb.z_index = 1
	get_tree().current_scene.add_child(xp_orb)

func _on_hitbox_body_entered(body):
	if !dead:
		if body.is_in_group("player_hurtbox"):
			body.get_parent().take_hit(1)
