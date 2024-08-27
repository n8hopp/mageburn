extends CharacterBody2D

var input_dir : Vector2
var speed : float = 200.0
var attack : bool = false
@onready var _animation = $AnimatedSprite2D

func _ready():
	pass

func _process(delta):
	if attack:
		if _animation.is_playing():
			return
		else:
			attack = false

	if !attack:
		if input_dir.length() > 0:
			_animation.play("Walk")
		else:
			_animation.play("Idle")
	
	if Input.is_action_just_pressed("attack"):
		attack = true
		_animation.play("Attack")
	
	
	if input_dir.x < 0:
		_animation.flip_h = true
	elif input_dir.x > 0:
		_animation.flip_h = false

func _physics_process(delta):
	if attack:
		return
		
	input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
		
	velocity = input_dir * speed
	move_and_slide()
	
