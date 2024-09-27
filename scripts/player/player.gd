extends Node2D

var input_dir : Vector2
var attack_dir : Vector2
var speed : float = 50.0
var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
@export var player_class : CharacterBody2D

var paladin_scene = preload("res://scenes/characters/paladin/paladin.tscn")
var archer_scene = preload("res://scenes/characters/archer/archer.tscn")

func take_hit(dmg_amount : int):
	if dead:
		return
	
	PlayerVariables.current_hp -= dmg_amount
	
	if PlayerVariables.current_hp <= 0:
		player_class._animation.play("death")
		dead = true
		PlayerVariables.death.emit()
		

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerVariables.selected_class == "Paladin":
		var paladin = paladin_scene.instantiate()
		player_class = paladin
		print(player_class)
		add_child(paladin)
		PlayerVariables.follow_target = paladin
		
	elif PlayerVariables.selected_class == "Archer":
		var archer = archer_scene.instantiate()
		player_class = archer
		add_child(archer)
		PlayerVariables.follow_target = archer
		
	PlayerVariables.strength = player_class.stats["str"]
	PlayerVariables.dexterity = player_class.stats["dex"]
	PlayerVariables.constitution = player_class.stats["cons"]
	PlayerVariables.intelligence = player_class.stats["intel"]
	PlayerVariables.wisdom = player_class.stats["wisdom"]
	PlayerVariables.charisma = player_class.stats["charisma"]
	PlayerVariables.current_health_pool = player_class.stats["health"]
	PlayerVariables.current_hp = player_class.stats["health"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead || !player_class:
		return
	
	if attack:
		pass
		if player_class._animation.is_playing():
			return
		else:
			attack = false
	
	if !attack:
		if input_dir.length() > 0:
			player_class._animation.play("walk")
		else:
			player_class._animation.play("idle")
	
	if Input.is_action_just_pressed("attack1"):
		attack = true
		player_class._animation.play("attack1")
	elif Input.is_action_just_pressed("attack2"):
		if PlayerVariables.k_locked:
			return
		else:
			attack = true
			player_class._animation.play("attack2")
	elif Input.is_action_just_pressed("attack3"):
		if PlayerVariables.l_locked:
			return
		else:
			attack = true
			# Archer trap placement doesn't have a 3rd attack animation that calls 
			# the function within the animation so we have to do it manually instead
			if PlayerVariables.selected_class == "Archer":
				player_class.place_trap()
			else:
				player_class._animation.play("attack3")
	
	if input_dir.x < 0:
		player_class._sprite.scale.x = -1
	elif input_dir.x > 0:
		player_class._sprite.scale.x = 1

func _physics_process(delta):
	if !player_class:
		return
	
	if attack or dead:
		return
	
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	if input_dir.length() != 0:
		attack_dir = input_dir
	
	player_class.velocity = input_dir * speed
	player_class.move_and_slide()
	
