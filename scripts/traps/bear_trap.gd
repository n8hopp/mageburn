extends Area2D

var start_position = Vector2.ZERO
var single_use = false
@onready var _animation = $AnimationPlayer
@onready var _trap_circle = $TrapCircle

var enemies_stunned : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

func _on_body_entered(body):
	if single_use == false:
		if body.is_in_group("hurtbox"):
			single_use = true
			_animation.play("close")
			_trap_circle.show()
			$TrapTimer.start()
			#Commented out as slimes are not an Area2D??
			#activated_trap(body)

func _on_area_entered(area):
	if single_use == false:
		if area.is_in_group("hurtbox"):
			single_use = true
			_animation.play("close")
			_trap_circle.show()
			$TrapTimer.start()
			area.get_parent().get_parent().get_stunned()
			enemies_stunned.append(area)

func _on_timer_timeout():
	queue_free()


func _on_trap_timer_timeout():
	queue_free()
	for enemy in enemies_stunned:
		enemy.get_parent().get_parent().get_unstunned()
	
