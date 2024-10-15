extends Button

@export var levelarrow_icon : Resource
var dice_mode : bool = false
func _on_dice_toggled(toggled_on):
	if toggled_on:
		icon = PlayerVariables.hit_die.icon
		dice_mode = true
	else:
		icon = levelarrow_icon
		dice_mode = false
		

