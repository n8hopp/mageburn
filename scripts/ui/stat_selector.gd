extends HBoxContainer

@onready var up_button = get_node("btn_up")
@onready var down_button = get_node("btn_down")
@onready var label = get_node("Label")
@onready var parent_panel = $"../../../../../../../../../.."
@onready var confirm = $"../../../../../Confirm"
var label_num = 0
var min_num = 0
var max_num = 20

func _ready():
	parent_panel.out_of_points.connect(_oop)
	parent_panel.points_free.connect(_un_oop)
	
	label_num = min_num
	label.text = str(label_num)

func _on_btn_down_pressed():
	if (label_num - 1) < min_num:
		return
	else:
		# adjust actual numbers (skill points & displayed skill #)
		label_num = label_num-1
		label.text = str(label_num)
		PlayerVariables.skill_points = PlayerVariables.skill_points + 1
		
		# emit signal to unlock other buttons
		parent_panel.points_free.emit()
		
		# after adjusting, if we're now at the bottom of adjustability, set disabled to true
		if label_num == min_num:
			down_button.disabled = true

func _on_btn_up_pressed():
	if (label_num + 1) > max_num:
		return
	else:
		# if valid up click, update label & remaining skill pts
		label_num += 1
		label.text = str(label_num)
		PlayerVariables.skill_points = PlayerVariables.skill_points - 1

		# if valid up click, then has to be points we can remove
		down_button.disabled = false
		
		# if we're at max level (20 by default) disable upgrading
		if label_num == max_num:
			up_button.disabled = true
			
		# if we are out of skill points, emit signal to lock all buttons
		if PlayerVariables.skill_points <= 0:
			parent_panel.out_of_points.emit()
			
func _oop():
	confirm.disabled = false
	up_button.disabled = true
	
func _un_oop():
	confirm.disabled = true
	up_button.disabled = false
