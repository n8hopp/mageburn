extends PanelContainer

@onready var confirm_button = $Panel/MarginContainer/VBoxContainer/VBoxContainer/Confirm
@onready var fixed_increase_label = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/hp_select/HBoxContainer/fixed
@onready var class_level_label = $Panel/MarginContainer/VBoxContainer/classlevel
@onready var dice_increase_label = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/hp_select/HBoxContainer/dice
@onready var stat_select_block = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/stat_select
# standard increase is the average roll of the die, rounded up
# & average roll is 1+sides / 2
@onready var standard_increase : float = roundi((PlayerVariables.hit_die.sides+1.0)/2.0)
@onready var modifier_symbol : String = PlayerVariables.modifier_symbol(PlayerVariables.con_bonus)

var con_increase_mod
@onready var str_selector = stat_select_block.find_child("str_selector")
@onready var dex_selector = stat_select_block.find_child("dex_selector")
@onready var con_selector = stat_select_block.find_child("con_selector")
@onready var inte_selector = stat_select_block.find_child("int_selector")
@onready var wis_selector = stat_select_block.find_child("wis_selector")
@onready var cha_selector = stat_select_block.find_child("cha_selector")

var heal_number = preload("res://scenes/ui/number_popup.tscn")

var paused : bool = false

signal out_of_points
signal points_free


func _ready():
	GameManager.level_up.connect(_toggle_visible)
	
func _on_confirm_pressed():
	var number_ui = heal_number.instantiate()
	number_ui.numtype = number_ui.NUMTYPE.HEAL
	
	if confirm_button.dice_mode:
		# change to increase health by this amount
		var hp_increase = PlayerVariables.hit_die.roll() + con_increase_mod
		PlayerVariables.current_health_pool += hp_increase
		PlayerVariables.current_hp += hp_increase
		number_ui.number = hp_increase

	else:
		# change to increase health by this amount
		var hp_increase = standard_increase + con_increase_mod
		PlayerVariables.current_health_pool += hp_increase
		PlayerVariables.current_hp += hp_increase
		number_ui.number = hp_increase
	PlayerVariables.level += 1
	
	PlayerVariables.follow_target.add_child(number_ui)
	
	if stat_select_block.visible == true:
		PlayerVariables.strength = str_selector.label_num
		PlayerVariables.dexterity = dex_selector.label_num
		PlayerVariables.constitution = con_selector.label_num
		PlayerVariables.intelligence = inte_selector.label_num
		PlayerVariables.wisdom = wis_selector.label_num
		PlayerVariables.charisma = cha_selector.label_num
	PlayerVariables.calculate_bonuses()
	modifier_symbol = PlayerVariables.modifier_symbol(PlayerVariables.con_bonus)
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
		stat.down_button.disabled = true
	
	points_free.emit()
	
func _on_visibility_changed():
	if visible == true:
		PlayerVariables.calculate_bonuses()
		modifier_symbol = PlayerVariables.modifier_symbol(PlayerVariables.con_bonus)
		var fixed_format_label = "fixed %s %s %s hp"
		fixed_increase_label.text = fixed_format_label % [standard_increase,modifier_symbol,abs(PlayerVariables.con_bonus)]
		
		var dice_format_label = "1d10 %s %s hp"
		dice_increase_label.text = dice_format_label % [modifier_symbol, abs(PlayerVariables.con_bonus)]
		
		#when we first load the popup, our con modifier is just our con bonus
		con_increase_mod = PlayerVariables.con_bonus
		
		var class_label = "%s - level %s"
		class_level_label.text = class_label % [PlayerVariables.selected_class, PlayerVariables.level+1]
		if (PlayerVariables.level + 1) % 2 == 0:
			_initialize_stat_block()
		else:
			stat_select_block.visible = false
			

func _toggle_visible():
	if paused:
		paused = false
		get_tree().paused = false
		hide()
	else:
		paused = true
		get_tree().paused = true
		show()
	
func con_update(value):
	# if we change constitution in the stat block, change the displayed modifier with what it would be upon levelup
	con_increase_mod = floori((value-10.0)/2.0)
	modifier_symbol = PlayerVariables.modifier_symbol(con_increase_mod)
	var fixed_format_label = "fixed %s %s %s hp"
	fixed_increase_label.text = fixed_format_label % [standard_increase,modifier_symbol,abs(con_increase_mod)]
	
	var dice_format_label = "1d10 %s %s hp"
	dice_increase_label.text = dice_format_label % [modifier_symbol, abs(con_increase_mod)]
	
