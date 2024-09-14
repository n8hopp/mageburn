extends PanelContainer

@onready var confirm_button = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Confirm
@onready var fixed_increase_label = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/hp_select/HBoxContainer/fixed
@onready var class_level_label = $Panel/MarginContainer/VBoxContainer/classlevel
@onready var stat_select_block = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/stat_select
# standard increase is the average roll of the die, rounded up
# & average roll is 1+sides / 2
@onready var standard_increase : float = roundi((PlayerVariables.hit_die.sides+1.0)/2.0)
@onready var modifier_symbol : String = PlayerVariables.modifier_symbol(PlayerVariables.con_bonus)

@onready var str_selector = stat_select_block.find_child("str_selector")
@onready var dex_selector = stat_select_block.find_child("dex_selector")
@onready var con_selector = stat_select_block.find_child("con_selector")
@onready var inte_selector = stat_select_block.find_child("int_selector")
@onready var wis_selector = stat_select_block.find_child("wis_selector")
@onready var cha_selector = stat_select_block.find_child("cha_selector")

var paused : bool = false

signal out_of_points
signal points_free

func _ready():
	GameManager.level_up.connect(_toggle_visible)
	
func _on_confirm_pressed():
	if confirm_button.dice_mode:
		# change to increase health by this amount
		PlayerVariables.current_health_pool += (PlayerVariables.hit_die.roll() + PlayerVariables.con_bonus)
	else:
		# change to increase health by this amount
		PlayerVariables.current_health_pool += (standard_increase + PlayerVariables.con_bonus)
	PlayerVariables.level += 1
	
	if stat_select_block.visible == true:
		PlayerVariables.strength = str_selector.label_num
		PlayerVariables.dexterity = dex_selector.label_num
		PlayerVariables.constitution = con_selector.label_num
		PlayerVariables.intelligence = inte_selector.label_num
		PlayerVariables.wisdom = wis_selector.label_num
		PlayerVariables.charisma = cha_selector.label_num
	PlayerVariables.calculate_bonuses()
	PlayerVariables.level_up()
	_toggle_visible()
		
func _initialize_stat_block():
	stat_select_block.visible = true
	PlayerVariables.skill_points = 2
	
	str_selector.min_num = PlayerVariables.strength
	dex_selector.min_num = PlayerVariables.dexterity
	con_selector.min_num = PlayerVariables.constitution
	inte_selector.min_num = PlayerVariables.intelligence
	wis_selector.min_num = PlayerVariables.wisdom
	cha_selector.min_num = PlayerVariables.charisma
	
	var statblocks = [str_selector, dex_selector, con_selector, 
			inte_selector, wis_selector, cha_selector]
	
	for stat in statblocks:
		stat.label_num = stat.min_num
		stat.label.text = str(stat.label_num)
	
	points_free.emit()
	
func _on_visibility_changed():
	if visible == true:
		var format_label = "fixed %s %s %s hp"
		fixed_increase_label.text = format_label % [standard_increase,modifier_symbol,abs(PlayerVariables.con_bonus)]
		
		var class_label = "%s - level %s"
		#class_level_label = class_labe
		if PlayerVariables.level % 4 == 0:
			_initialize_stat_block()
		else:
			stat_select_block.visible = false
			
func _toggle_visible():
	if paused:
		paused = false
		hide()
	else:
		paused = true
		show()
	
