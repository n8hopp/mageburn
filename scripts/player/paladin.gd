extends CharacterBody2D

var input_dir : Vector2
var attack_dir = Vector2.RIGHT
var speed : float = 50.0
var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var wave_attack_scene = preload("res://scenes/characters/paladin/wave_attack.tscn")
var fire_attack_scene = preload("res://scenes/characters/paladin/fire_arc_attack.tscn")
@export var j_texture : Texture
@export var k_texture : Texture
@export var l_texture : Texture
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D
var stats : Dictionary = {
		"str": 5, 
		"dex": 3, 
		"cons": 4, 
		"intel": 2, 
		"wisdom": 1, 
		"charisma": 2, 
		"health": 15 
		}

func _ready():
	pass

func wave_attack():
	var wave_attack_instance = wave_attack_scene.instantiate()
	
	wave_attack_instance.position = global_position
	
	#stat scaling!:
	var base_damage = 5
	wave_attack_instance.damage = roundf(base_damage + (PlayerVariables.strength * 0.6)) # Slightly lower Strength scaling
	PlayerVariables.k_cooldown.wait_time = 3.0 - (PlayerVariables.dexterity * 0.05) # Dex reduces cooldown
	#####
	
	get_tree().current_scene.add_child(wave_attack_instance)
	wave_attack_instance.set_direction(get_parent().attack_dir)

func fire_attack():
	var fire_attack_instance = fire_attack_scene.instantiate()
	fire_attack_instance.position = global_position
	
	# stat scaling!:
	var base_damage = 10
	fire_attack_instance.damage = roundf(base_damage + (PlayerVariables.strength * 0.8) + (PlayerVariables.intelligence * 1.0)) # Intelligence adds fire scaling
	PlayerVariables.l_cooldown.wait_time = 10.0 - (PlayerVariables.dexterity * 0.05) # Dex reduces cooldown
	
	get_tree().current_scene.add_child(fire_attack_instance)
	fire_attack_instance.set_direction(get_parent().attack_dir)

func _on_hitbox_area_entered(area):
	if area.is_in_group("hurtbox"):
		#knockback on sword swing
		var knockback = global_position.direction_to(area.global_position)
		area.knockback = knockback * knockback_coef
		
		#damage on sword swing
		var base_damage = 5
		var damage = roundf(base_damage + (PlayerVariables.strength * 0.8)) # Sword swing scales with Strength
		area.take_damage(damage)

func _start_cooldown(attack_name : String):
	PlayerVariables.cooldown_ability(attack_name)
