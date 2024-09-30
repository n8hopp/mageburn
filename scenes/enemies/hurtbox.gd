extends Area2D

var knockback
@onready var parent = $"../.."

func take_damage(damage):
	parent.knockback = knockback
	parent.take_damage(damage)
	
func get_stunned():
	parent.get_stunned()
	
func get_unstunned():
	parent.get_unstunned()
