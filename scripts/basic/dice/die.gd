class_name Die
extends Node

# die class for rolling
@export var sides : int
var most_recent_result : int

@export var icon : Resource

func _init(s : int):
	sides = s

func roll():
	most_recent_result = randi_range(1, sides)
	return most_recent_result
