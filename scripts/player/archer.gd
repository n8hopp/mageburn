extends CharacterBody2D

var input_dir : Vector2
var attack_dir : Vector2
var speed : float = 50.0
var attack : bool = false
var knockback_coef = 200.0
var arrow_scene = preload("res://scenes/characters/archer/arrow.tscn")
var charged_shot_scene = preload("res://scenes/characters/archer/charged_shot.tscn")
var trap_scene = preload("res://scenes/characters/archer/bear_trap.tscn")
@onready var _animation = $AnimationPlayer
@onready var _sprite = $Sprite2D


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
		place_trap()
	
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
