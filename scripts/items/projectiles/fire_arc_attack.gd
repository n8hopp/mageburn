extends Area2D

var start_position = Vector2.ZERO
var velocity = Vector2.ZERO
var range = 100.0
var speed = 100.0
var knockback_coef = 100.0
var damage : float
@onready var _animation = $AnimationPlayer

var enemies_hit : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	_animation.play("arc_spread")

func set_direction(direction: Vector2):
	velocity = direction.normalized() * speed
	scale.x = direction.normalized().x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("hurtbox"):
		if !enemies_hit.has(body):
			var knockback = global_position.direction_to(body.global_position)
			body.knockback = knockback * knockback_coef
			body.take_damage(damage)
		
func _on_area_entered(area):
	if area.is_in_group("hurtbox"):
		if !enemies_hit.has(area):
			var knockback = global_position.direction_to(area.global_position)
			area.knockback = knockback * knockback_coef
			enemies_hit.append(area)
			area.take_damage(damage)
