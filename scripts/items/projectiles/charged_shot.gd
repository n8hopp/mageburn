extends Area2D

var velocity = Vector2.ZERO
var range = 1000.0
var speed = 400.0
var start_position = Vector2.ZERO
var knockback_coef = 300.0
var pierce_amount
var damage
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

#func _on_body_entered(body):
	#if body.is_in_group("hurtbox"):
		#var knockback = global_position.direction_to(body.global_position)
		#body.knockback = knockback * knockback_coef 
		#body.take_damage(damage)

func _on_area_entered(area):
	if area.is_in_group("hurtbox") and !area.parent.dead:
		if !enemies_hit.has(area):
			var knockback = global_position.direction_to(area.global_position)
			area.knockback = knockback * knockback_coef
			enemies_hit.append(area)
			pierce_amount -= 1
			area.take_damage(damage)
			_heatseek(area)
		if pierce_amount <= 0:
			queue_free()

func _heatseek(area):
	var close_enemies = $DetectionRadius.get_overlapping_areas()
	var closest_enemy
	var closest_distance = $DetectionRadius.get_node("CollisionShape2D").shape.radius
	for enemy in close_enemies:
		if enemy == area:
			continue
		if enemy.is_in_group("hurtbox") and !enemy.parent.dead:
			var enemy_distance = global_position.distance_to(enemy.global_position)
			if enemy_distance < closest_distance:
				closest_distance = enemy_distance
				closest_enemy = enemy
		
	if closest_enemy != null:
		set_direction(global_position.direction_to(closest_enemy.global_position))
	
