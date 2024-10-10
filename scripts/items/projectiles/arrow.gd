extends Area2D

var velocity = Vector2.ZERO
var range = 100.0
var speed = 200.0
var damage
var start_position = Vector2.ZERO
var knockback_coef = 200.0

var enemies_hit : Array

func _ready():
	start_position = global_position
	
func set_direction(direction: Vector2):
	velocity = direction.normalized() * speed
	rotation = velocity.angle()

func _process(delta: float):
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range: 
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("hurtbox"):
		var knockback = global_position.direction_to(body.global_position)
		body.knockback = knockback * knockback_coef
		body.take_damage(damage)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("hurtbox") && !area.parent.dead:
		if !enemies_hit.has(area):
			var knockback = global_position.direction_to(area.global_position)
			area.knockback = knockback * knockback_coef
			enemies_hit.append(area)
			area.take_damage(damage)
		queue_free()
