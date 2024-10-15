extends TextureRect

@onready var cooldown_bar : ProgressBar = $"../KCooldown"
@onready var cooldown_text : Label = $"../KCoolLabel"
var cooldown_active = false
func _ready():
	PlayerVariables.unlock_k.connect(unlock)
	texture = PlayerVariables.k_texture
	PlayerVariables.cooldown_k.connect(cooldown)

func unlock():
	material = null
	
func cooldown():
	cooldown_active = true
	cooldown_bar.max_value = PlayerVariables.k_cooldown.wait_time
	cooldown_text.visible = true
	
func _process(delta):
	if cooldown_active == true:
		if PlayerVariables.k_cooldown.time_left >= 0.0:
			cooldown_bar.value = PlayerVariables.k_cooldown.time_left
			var floatstr = "%3.1f" % PlayerVariables.k_cooldown.time_left
			cooldown_text.text = floatstr
		if PlayerVariables.k_cooldown.time_left == 0.0:
			cooldown_text.visible = false
			cooldown_active = false
