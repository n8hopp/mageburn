extends CharacterBody2D

var input_dir : Vector2
var speed : float = 50.0
var attack : bool = false
var knockback_coef = 200.0
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
	
	
	if input_dir.x < 0:
		_sprite.scale.x = -1
	elif input_dir.x > 0:
		_sprite.scale.x = 1

func _physics_process(delta):
	if attack:
		return
		
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
		
	velocity = input_dir * speed
	move_and_slide()

func _on_hitbox_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()


func _on_hitbox_body_entered(body):
	if body.is_in_group("hurtbox"):
		var knockback = global_position.direction_to(body.global_position)
		body.knockback = knockback * knockback_coef
		body.take_damage()
