extends CharacterBody2D

var input_dir : Vector2
var attack_dir : Vector2
var speed : float = 50.0
var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var wave_attack_scene = preload("res://scenes/characters/paladin/wave_attack.tscn")
var fire_attack_scene = preload("res://scenes/characters/paladin/fire_arc_attack.tscn")
var player_variables_scene = preload("res://scenes/basic_items/PlayerVariables.tscn")
var player_variables = player_variables_scene.instantiate()
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D

func take_hit(dmg_amount : int): 
	if dead: 
		return
		
	player_variables.current_hp  -= dmg_amount
	_animation.play("hurt")
	
	if player_variables.current_hp <= 0:
		_animation.play("death")
		dead = true

func _ready():
	pass

func _process(delta):
	if attack:
		pass
		if _animation.is_playing():
			return
		else:
			attack = false
#
	if !attack:
		if input_dir.length() > 0:
			_animation.play("walk")
		else:
			_animation.play("idle")
	
	if Input.is_action_just_pressed("attack1"):
		attack = true
		_animation.play("attack1")
	elif Input.is_action_just_pressed("attack2"):
		attack = true
		_animation.play("attack2")
	elif Input.is_action_just_pressed("attack3"):
		attack = true
		_animation.play("attack3")
	
	
	if input_dir.x < 0:
		_sprite.scale.x = -1
	elif input_dir.x > 0:
		_sprite.scale.x = 1

func _physics_process(delta):
	if attack:
		return
		
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	if input_dir.length() != 0:
		attack_dir = input_dir
		
	velocity = input_dir * speed
	move_and_slide()
	
func wave_attack():
	var wave_attack_instance = wave_attack_scene.instantiate()
	wave_attack_instance.position = global_position
	get_tree().current_scene.add_child(wave_attack_instance)
	wave_attack_instance.set_direction(attack_dir)
	
func fire_attack():
	var fire_attack_instance = fire_attack_scene.instantiate()
	fire_attack_instance.position = global_position
	get_tree().current_scene.add_child(fire_attack_instance)
	fire_attack_instance.set_direction(attack_dir)

func _on_hitbox_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()

func _on_hitbox_body_entered(body):
	if body.is_in_group("hurtbox"):
		var knockback = global_position.direction_to(body.global_position)
		body.knockback = knockback * knockback_coef
		body.take_damage()
