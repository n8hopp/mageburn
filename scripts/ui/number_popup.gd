extends Control

enum NUMTYPE {DAMAGE, HEAL}
@export var numtype : NUMTYPE

@export var label : Label
@export var damage_color : Color
@export var heal_color : Color

var number

func _ready():
	match numtype:
		NUMTYPE.DAMAGE:
			label.label_settings.font_color = damage_color
			label.label_settings.outline_color = Color.BLACK
			label.text = "-" + str(number)
		NUMTYPE.HEAL:
			label.label_settings.font_color = heal_color
			label.label_settings.outline_color = Color.BLACK
			label.text = "+" + str(number)
			
	var tween = create_tween().set_parallel(true)
	tween.tween_property(label, "position", Vector2(0, -20), 1)
	tween.tween_property(label, "modulate", Color.TRANSPARENT, 1)
	tween.chain().tween_callback(queue_free)
