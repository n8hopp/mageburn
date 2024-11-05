extends CharacterBody2D

var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var crystal_scene
var fireball_scene = preload("res://scenes/characters/wizard/fireball.tscn")
var heal_scene
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

func summon_crystal():
	pass

func summon_fireball():
	var fireball_instance = fireball_scene.instantiate()
	fireball_instance.position = global_position
	
	var base_damage = 10
	fireball_instance.damage = roundf(base_damage + (PlayerVariables.strength * 0.7) + (PlayerVariables.intelligence * 1.0))
	PlayerVariables.k_cooldown.wait_time = 10.0 - (PlayerVariables.dexterity * 0.05)
	
	get_tree().current_scene.add_child(fireball_instance)
	fireball_instance.set_direction(get_parent().attack_dir)
	fireball_instance._animation.play("fireball")

func summon_heal():
	pass

func _start_cooldown(attack_name : String):
	PlayerVariables.cooldown_ability(attack_name)
