extends TextureRect

func _ready():
	PlayerVariables.unlock_k.connect(unlock)
	texture = PlayerVariables.k_texture
	
func unlock():
	material = null
