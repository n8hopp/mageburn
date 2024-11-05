extends Area2D

@onready var _animation = $AnimationPlayer

var velocity = Vector2.ZERO
var range = 400.0
var speed = 200.0
var damage
var start_position = Vector2.ZERO
var knockback_coef = 200.0
var exploded = false

var enemies_hit : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = global_position

func set_direction(direction: Vector2):
	velocity = direction.normalized() * speed
	rotation = velocity.angle()
	if direction.normalized().x > 0: # looking right (including diagonals)
		scale.y = 1
	else: # looking left (including diagonals)
		scale.y = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.distance_to(start_position) > range: 
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") && !area.parent.dead:
		if !enemies_hit.has(area):
			var true_damage = damage
			if exploded == false:
				_animation.play("fireball_hit")
				exploded = true
				true_damage += 5
			
			var knockback = global_position.direction_to(area.global_position)
			area.knockback = knockback * knockback_coef
			enemies_hit.append(area)
			area.take_damage(true_damage)

func remove_fireball():
	queue_free()
