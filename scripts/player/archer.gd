extends CharacterBody2D

var input_dir : Vector2
var attack_dir = Vector2.RIGHT
var speed : float = 50.0
var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var arrow_scene = preload("res://scenes/characters/archer/arrow.tscn")
var charged_shot_scene = preload("res://scenes/characters/archer/charged_shot.tscn")
var trap_scene = preload("res://scenes/characters/archer/bear_trap.tscn")
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D
var stats : Dictionary = {"str": 0, "dex": 0, "cons": 0, 
	"intel": 0, "wisdom": 0, "charisma": 0,  "health": 10}

func _ready():
	pass

func fire_arrow():
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.position = global_position
	
	# stat scaling
	var base_damage = 8
	arrow_instance.damage = base_damage + (PlayerVariables.strength * 0.7) # Bow still scales with Strength but less
	
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.set_direction(get_parent().attack_dir)

func fire_charged_shot():
	var charged_shot_instance = charged_shot_scene.instantiate()
	charged_shot_instance.position = global_position
	
	# stat scaling
	var base_damage = 15
	charged_shot_instance.pierce_amount = 8 + (PlayerVariables.dexterity * 0.5) # Dexterity increases pierce count
	charged_shot_instance.damage = base_damage + (PlayerVariables.strength * 0.7) # Bow still scales with Strength but less
	
	get_tree().current_scene.add_child(charged_shot_instance)
	charged_shot_instance.set_direction(get_parent().attack_dir)
	
func place_trap():
	var trap_instance = trap_scene.instantiate()
	trap_instance.position = global_position
	
	#var base_duration = 5.0
	#var duration = base_duration + (PlayerVariables.constitution * 0.2) # Constitution increases trap duration
	#var radius = 1.0 + (PlayerVariables.wisdom * 0.1) # Wisdom increases trap radius
	get_tree().current_scene.add_child(trap_instance)

func _start_cooldown(attack_name : String):
	PlayerVariables.cooldown_ability(attack_name)
