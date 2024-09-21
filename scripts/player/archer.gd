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
var archer_stats : Dictionary = {"str": 0, "dex": 0, "cons": 0, 
	"intel": 0, "wisdom": 0, "charisma": 0,  "health": 10}

func _ready():
	pass

func _physics_process(delta):
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	if input_dir.length() != 0:
		attack_dir = input_dir

func fire_arrow():
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.position = global_position
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.set_direction(attack_dir)

func fire_charged_shot():
	var charged_shot_instance = charged_shot_scene.instantiate()
	charged_shot_instance.position = global_position
	get_tree().current_scene.add_child(charged_shot_instance)
	charged_shot_instance.set_direction(attack_dir)
	
func place_trap():
	var trap_instance = trap_scene.instantiate()
	trap_instance.position = global_position
	get_tree().current_scene.add_child(trap_instance)
