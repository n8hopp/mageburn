extends Control

enum NUMTYPE {DAMAGE, HEAL, CRIT}
@export var numtype : NUMTYPE

@export var label : Label
@export var damage_color : Color
@export var heal_color : Color
@export var crit_color : Color
var number

func _ready():
	var timelength : float
	match numtype:
		NUMTYPE.DAMAGE:
			label.label_settings.font_color = damage_color
			label.label_settings.outline_color = Color.BLACK
			label.text = "-" + str(number)
			timelength = 1
		NUMTYPE.HEAL:
			label.label_settings.font_color = heal_color
			label.label_settings.outline_color = Color.BLACK
			label.text = "+" + str(number)
			timelength = 3
		NUMTYPE.CRIT:
			label.label_settings.font_color = crit_color
			label.label_settings.outline_color = Color.BLACK
			label.text = "-" + str(number) + "!"
			timelength = 1.5
			
	var tween = create_tween().set_parallel(true)
	tween.tween_property(label, "position", Vector2(0, -20), timelength)
	tween.tween_property(label, "modulate", Color.TRANSPARENT, timelength)
	tween.chain().tween_callback(queue_free)
