extends Area2D
var knockback

func take_damage(damage):
	var parent = $"../.."
	parent.knockback = knockback
	parent.take_damage(damage)
	
func get_stunned():
	var parent = $"../.."
	parent.get_stunned()
