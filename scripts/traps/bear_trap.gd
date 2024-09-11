extends Area2D

var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

func _on_body_entered(body):
	if body.is_in_group("hurtbox"):
		body.take_damage()
		queue_free()
		

func _on_timer_timeout():
	queue_free()
