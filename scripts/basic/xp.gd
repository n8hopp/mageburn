extends Area2D

@export var value = 1
var chasing := false
var target : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if chasing:
		global_position = global_position.lerp(target.global_position, 0.1)

func _on_body_entered(body):
	if body.is_in_group("player_hurtbox"):
		PlayerVariables.current_experience += value
		if PlayerVariables.current_experience >= PlayerVariables.experience_to_level:
			GameManager.level_up.emit()
		queue_free()
		

func _on_area_entered(area):
	if area.is_in_group("xp_magnet"):
		target = area.get_parent()
		chasing = true
		
