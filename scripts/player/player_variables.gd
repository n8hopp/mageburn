extends Node

@export_category("Basic Stats")
@export var current_health_pool : int
@export var level : int = 4
@export var strength : int
@export var dexterity : int
@export var constitution : int
@export var intelligence : int
@export var wisdom : int
@export var charisma : int
@export var hit_die : Die
@export var current_experience : int
@export var experience_to_level : int

@export_category("Ability 1 Stats")
@export var j_damage_multiplier : float
@export var j_speed_multiplier : float
@export var j_cooldown_multiplier : float
@export var j_knockback_multiplier : float

@export_category("Ability 2 Stats")
@export var k_damage_multiplier : float
@export var k_speed_multiplier : float
@export var k_cooldown_multiplier : float
@export var k_knockback_multiplier : float

@export_category("Ability 3 Stats")
@export var l_damage_multiplier : float
@export var l_speed_multiplier : float
@export var l_cooldown_multiplier : float
@export var l_knockback_multiplier : float

# ability modifiers - what we actually use when rolling
var str_bonus : int
var dex_bonus : int
var con_bonus : int
var int_bonus : int
var wis_bonus : int
var cha_bonus : int

# used when increasing stats every 4 levels
var skill_points : int

func calculate_bonuses():
	str_bonus = floori((strength-10.0)/2.0)
	dex_bonus = floori((dexterity-10.0)/2.0)
	con_bonus = floori((constitution-10.0)/2.0)
	int_bonus = floori((intelligence-10.0)/2.0)
	wis_bonus = floori((wisdom-10.0)/2.0)
	cha_bonus = floori((charisma-10.0)/2.0)
	
func modifier_symbol(bonus):
	if bonus >= 0:
		return "+"
	elif bonus < 0:
		return "-"
	
func _ready():
	hit_die = Die.new(10)
	hit_die.icon = preload("res://assets/ui/icon_d10.tres")
	
	calculate_bonuses()



