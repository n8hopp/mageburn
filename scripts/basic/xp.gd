extends Area2D

@export var value = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player_hurtbox"):
		PlayerVariables.current_experience += 1
		if PlayerVariables.current_experience == PlayerVariables.experience_to_level:
			GameManager.level_up.emit()
		queue_free()

