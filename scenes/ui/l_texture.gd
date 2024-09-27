extends TextureRect

@onready var cooldown_bar : ProgressBar = $"../LCooldown"
@onready var cooldown_text : Label = $"../LCoolLabel"
var cooldown_active = false

func _ready():
	PlayerVariables.unlock_l.connect(unlock)
	texture = PlayerVariables.l_texture
	PlayerVariables.cooldown_l.connect(cooldown)

func unlock():
	material = null
	
func cooldown():
	cooldown_active = true
	cooldown_bar.max_value = PlayerVariables.l_cooldown.wait_time
	cooldown_text.visible = true
	
func _process(delta):
	if cooldown_active == true:
		if PlayerVariables.l_cooldown.time_left >= 0.0:
			cooldown_bar.value = PlayerVariables.l_cooldown.time_left
			var floatstr = "%3.1f" % PlayerVariables.l_cooldown.time_left
			cooldown_text.text = floatstr
		if PlayerVariables.l_cooldown.time_left == 0.0:
			cooldown_text.visible = false
			cooldown_active = false
	
