extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func update():
	value = PlayerVariables.current_experience * 100 / PlayerVariables.experience_to_level
