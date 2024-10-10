extends PanelContainer

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.boss_dead.connect(_toggle_visible)


func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_try_again_button_pressed():
	_toggle_visible()

func _toggle_visible():
	if paused:
		paused = false
		get_tree().paused = false
		hide()
	else:
		paused = true
		show()
		get_tree().paused = true
		
