class_name CharacterType
extends RefCounted

var spritesheet : Resource = null
var anim : Resource 
var icon_ability1 : Resource = null
var icon_ability2 : Resource = null
var icon_ability3 : Resource = null

var classname : StringName = "UNDEFINED"
var base_statblock : Dictionary = {
	"str": 0,
	"dex": 0,
	"con": 0,
	"int": 0,
	"wis": 0,
	"cha": 0
}

