
extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	update()

func _draw():
	var hero = get_parent().hero
	draw_rect(Rect2(Vector2(0,0), Vector2(100,70*(1.0-float(hero.energy)/float(hero.energy_max)))), Color("DBED18"))