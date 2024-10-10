extends Area2D

var start_position = Vector2.ZERO
var single_use = false
var duration : float
var trap_radius : float
@onready var _animation = $AnimationPlayer
@onready var _trap_circle = $TrapCircle
@onready var _trap_collision_shape = $TrapCircle/TrapCollisionShape

var enemies_stunned : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	_trap_collision_shape.shape.radius = trap_radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

func _on_area_entered(area):
	if single_use == false:
		if area.is_in_group("hurtbox") && !area.parent.dead:
			single_use = true
			_animation.play("close")
			_trap_circle.show()
			$TrapTimer.wait_time = duration
			$TrapTimer.start()
			area.parent.get_stunned()
			enemies_stunned.append(area)
			
			for enemy in _trap_circle.get_overlapping_areas():
				if enemy.is_in_group("hurtbox") && !enemy.parent.dead:
					enemies_stunned.append(enemy)
					enemy.parent.get_stunned()

func _on_timer_timeout():
	queue_free()

func _on_trap_timer_timeout():
	queue_free()
	for enemy in enemies_stunned:
		if is_instance_valid(enemy):
			enemy.parent.get_unstunned()
