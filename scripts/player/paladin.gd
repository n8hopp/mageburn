extends CharacterBody2D

var input_dir : Vector2
var attack_dir = Vector2.RIGHT
var speed : float = 50.0
var attack : bool = false
var dead : bool = false
var knockback_coef = 200.0
var wave_attack_scene = preload("res://scenes/characters/paladin/wave_attack.tscn")
var fire_attack_scene = preload("res://scenes/characters/paladin/fire_arc_attack.tscn")
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D
var paladin_stats : Dictionary = {"str": 0, "dex": 0, "cons": 0, 
	"intel": 0, "wisdom": 0, "charisma": 0, "health": 15}

func _ready():
	pass

func _physics_process(delta):
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	if input_dir.length() != 0:
		attack_dir = input_dir
	
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
		var knockback = global_position.direction_to(area.global_position)
		area.knockback = knockback * knockback_coef
		area.take_damage()

func _on_hitbox_body_entered(body):
	if body.is_in_group("hurtbox"):
		var knockback = global_position.direction_to(body.global_position)
		body.knockback = knockback * knockback_coef
		body.take_damage()
