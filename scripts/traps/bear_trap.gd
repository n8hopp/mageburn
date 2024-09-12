extends Area2D

var start_position = Vector2.ZERO
var single_use = false
@onready var _animation = $AnimationPlayer
@onready var _trap_circle = $TrapCircle

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
			activated_trap(body)
			

func activated_trap(body: Node2D):
	body.velocity = Vector2(0,0)


func _on_timer_timeout():
	queue_free()


func _on_trap_timer_timeout():
	queue_free()
