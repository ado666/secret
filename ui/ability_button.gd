
extends Button

var hero = null
signal cast_spell(hero)

func _ready():
	#get_node("player").play("meteor")
	pass

func set_text(text):
	get_node("Label").set_text(text)

func _pressed():
	emit_signal("cast_spell",hero)
