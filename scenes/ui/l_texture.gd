extends TextureRect

func _ready():
	PlayerVariables.unlock_l.connect(unlock)
	texture = PlayerVariables.l_texture
	
func unlock():
	material = null
