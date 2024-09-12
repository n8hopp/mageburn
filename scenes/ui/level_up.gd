extends PanelContainer

@onready var confirm_button = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Confirm
@onready var fixed_increase_label = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/hp_select/HBoxContainer/fixed
@onready var stat_select_block = $Panel/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/stat_select
# standard increase is the average roll of the die, rounded up
# & average roll is 1+sides / 2
@onready var standard_increase : float = roundi((PlayerVariables.hit_die.sides+1.0)/2.0)
@onready var modifier_symbol : String = PlayerVariables.modifier_symbol(PlayerVariables.con_bonus)

signal out_of_points
signal points_free

func _ready():
	var format_label = "fixed %s %s %s hp"
	fixed_increase_label.text = format_label % [str(standard_increase),modifier_symbol,abs(PlayerVariables.con_bonus)]
	
	if PlayerVariables.level % 4 == 0:
		_initialize_stat_block()
	else:
		stat_select_block.visible = false

func _on_confirm_pressed():
	if confirm_button.dice_mode:
		# change to increase health by this amount
		PlayerVariables.current_health_pool += (PlayerVariables.hit_die.roll() + PlayerVariables.con_bonus)
	else:
		# change to increase health by this amount
		PlayerVariables.current_health_pool += (standard_increase + PlayerVariables.con_bonus)
	PlayerVariables.level += 1
		
func _initialize_stat_block():
	stat_select_block.visible = true
	PlayerVariables.skill_points = 2
	
	# player cannot proceed without spending skill points
	confirm_button.disabled = true
	
	var str = stat_select_block.find_child("str_selector")
	var dex = stat_select_block.find_child("dex_selector")
	var con = stat_select_block.find_child("con_selector")
	var inte = stat_select_block.find_child("int_selector")
	var wis = stat_select_block.find_child("wis_selector")
	var cha = stat_select_block.find_child("cha_selector")
	
	str.min_num = PlayerVariables.strength
	dex.min_num = PlayerVariables.dexterity
	con.min_num = PlayerVariables.constitution
	inte.min_num = PlayerVariables.intelligence
	wis.min_num = PlayerVariables.wisdom
	cha.min_num = PlayerVariables.charisma
	
