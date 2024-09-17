extends Area2D
var knockback

func take_damage():
	var parent = $"../.."
	parent.knockback = knockback
	parent.take_damage()
