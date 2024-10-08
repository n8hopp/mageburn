extends Node

@export_category("Basic Stats")
@export var current_health_pool : int = 10

var current_hp : int = current_health_pool

@export var level : int = 1
#default standard array for martial class (paladin)
#TODO: change based on class selected
@export var strength : int = 15
@export var dexterity : int = 12
@export var constitution : int = 14
@export var intelligence : int = 8
@export var wisdom : int = 10
@export var charisma : int = 14
@export var hit_die : Die
@export var current_experience : int = 0
@export var experience_to_level : int = 5

#@export_category("Ability 1 Stats")
#@export var j_damage : float # paladin: str
#@export var j_speed : float # paladin: dex
#@export var j_cooldown : float # paladin: dex/wis
#@export var j_knockback : float # paladin: str
#
#@export_category("Ability 2 Stats")
@export var k_locked : bool = true # level 5
#@export var k_damage : float # paladin: str
#@export var k_speed : float # paladin: str
#@export var k_cooldown : float # paladin: dex/wis
#@export var k_knockback : float # paladin: str
#
#@export_category("Ability 3 Stats")
@export var l_locked : bool = true # level 10
#@export var l_damage : float # paladin: str + int
#@export var l_speed : float # paladin: dex + wis
#@export var l_cooldown : float # paladin: dex + wis
#@export var l_knockback : float # paladin: str + cha

var j_texture : Texture
var k_texture : Texture
var l_texture : Texture

# ability modifiers - what we actually use when rolling
var str_bonus : int
var dex_bonus : int
var con_bonus : int
var int_bonus : int
var wis_bonus : int
var cha_bonus : int

# used when increasing stats every 4 levels
var skill_points : int

signal death
var selected_class = &""
var nux_mode = false
var follow_target : CharacterBody2D

signal unlock_k
signal unlock_l
signal cooldown_j
signal cooldown_k
signal cooldown_l
var j_cooldown = Timer.new()
var k_cooldown = Timer.new()
var l_cooldown = Timer.new()

var j_on_cd = false
var k_on_cd = false
var l_on_cd = false

func _ready():
	# setting necessary variables for cooldown timers
	j_cooldown.one_shot = true
	j_cooldown.timeout.connect(_on_cd_end.bind('j'))
	
	k_cooldown.one_shot = true
	k_cooldown.timeout.connect(_on_cd_end.bind('k'))
	
	l_cooldown.one_shot = true
	l_cooldown.timeout.connect(_on_cd_end.bind('l'))
	
	add_child(j_cooldown)
	add_child(k_cooldown)
	add_child(l_cooldown)
	
	# TODO: setting necessary values for hit_die based on class
	hit_die = Die.new(10)
	hit_die.icon = preload("res://assets/ui/icon_d10.tres")
	
	calculate_bonuses()

func calculate_bonuses():
	str_bonus = floori((strength-10.0)/2.0)
	dex_bonus = floori((dexterity-10.0)/2.0)
	if(((constitution-10.0)/2.0)>0):
		con_bonus = floori((constitution-10.0)/2.0)
	else:
		con_bonus = 0
	int_bonus = floori((intelligence-10.0)/2.0)
	wis_bonus = floori((wisdom-10.0)/2.0)
	cha_bonus = floori((charisma-10.0)/2.0)
	
func modifier_symbol(bonus):
	if bonus >= 0:
		return "+"
	elif bonus < 0:
		return "-"
	
func level_up():
	if level == 5:
		k_locked = false
		unlock_k.emit()
	
	if level == 10:
		l_locked = false
		unlock_l.emit()
	
	current_experience = 0
	experience_to_level = experience_to_level + 5
	follow_target.speed = 50.0 + (2.5 * dexterity)
	
func cooldown_ability(ability_name):
	match ability_name:
		'j':
			j_on_cd = true
			j_cooldown.start()
			cooldown_j.emit()
		'k':
			k_on_cd = true
			k_cooldown.start()
			cooldown_k.emit()
		'l':
			l_on_cd = true
			l_cooldown.start()
			cooldown_l.emit()

func _on_cd_end(ability_name):
	match ability_name:
		'j':
			j_on_cd = false
		'k':
			k_on_cd = false
		'l':
			l_on_cd = false

func crit_roll(damage):
	cha_bonus = floori((charisma-10.0)/2.0)
	var d20 = Die.new(20)
	var critted : bool = false
	var roll = d20.roll() 
	var mod_roll = roll + cha_bonus
	print(mod_roll)
	if roll == 20 or mod_roll > 20:
		damage = damage * 2
		critted = true
		
	print("damage: " + str(damage))
	return [damage, critted]







