extends Area2D

var start_position = Vector2.ZERO
var velocity = Vector2.ZERO
var range = 100.0
var speed = 100.0
var knockback_coef = 100.0
@onready var _animation = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	_animation.play("arc_spread")

func set_direction(direction: Vector2):
	velocity = direction.normalized() * speed
	rotation = velocity.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("hurtbox"):
		var knockback = global_position.direction_to(body.global_position)
		body.knockback = knockback * knockback_coef
		body.take_damage()
