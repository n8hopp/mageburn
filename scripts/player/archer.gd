extends CharacterBody2D

var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var arrow_scene = preload("res://scenes/characters/archer/arrow.tscn")
var charged_shot_scene = preload("res://scenes/characters/archer/charged_shot.tscn")
var trap_scene = preload("res://scenes/characters/archer/bear_trap.tscn")
@export var j_texture : Texture
@export var k_texture : Texture
@export var l_texture : Texture
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D
var stats : Dictionary = {
		"str": 3, 
		"dex": 5, 
		"cons": 4, 
		"intel": 1, 
		"wisdom": 2, 
		"charisma": 2,
		"health": 10
		}
var speed : float = 50.0 + (2.5 * stats.dex)
func _ready():
	pass

func fire_arrow():
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.position = global_position
	
	# stat scaling
	var base_damage = 3
	arrow_instance.damage = roundf(base_damage + (PlayerVariables.strength * 0.7)) # Bow still scales with Strength but less
	
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.set_direction(get_parent().attack_dir)

func fire_charged_shot():
	var charged_shot_instance = charged_shot_scene.instantiate()
	charged_shot_instance.position = global_position
	
	# stat scaling
	var base_damage = 2
	charged_shot_instance.pierce_amount = roundf(3 + (PlayerVariables.dexterity * 0.5)) # Dexterity increases pierce count
	charged_shot_instance.damage = roundf(base_damage + (PlayerVariables.strength * 0.4)) # Bow still scales with Strength but less
	PlayerVariables.k_cooldown.wait_time = 1.0 - (PlayerVariables.dexterity * 0.05) # Dex reduces cooldown
	
	get_tree().current_scene.add_child(charged_shot_instance)
	charged_shot_instance.set_direction(get_parent().attack_dir)
	
func place_trap():
	var trap_instance = trap_scene.instantiate()
	trap_instance.position = global_position
	
	var base_duration = 5.0
	trap_instance.duration = base_duration + (PlayerVariables.constitution * 0.2) # Constitution increases trap duration
	trap_instance.trap_radius = 20.0 + (PlayerVariables.wisdom * 0.5) # Wisdom increases trap radius
	
	PlayerVariables.l_cooldown.wait_time = 8.0 - (PlayerVariables.dexterity * 0.05) # Dex reduces cooldown
	
	# Must manually call this as the placing of the trap has no animation to attach it to.
	_start_cooldown("l")
	
	get_tree().current_scene.add_child(trap_instance)

func _start_cooldown(attack_name : String):
	PlayerVariables.cooldown_ability(attack_name)
