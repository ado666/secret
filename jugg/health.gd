
extends Node2D

const LOW_HP_COLOR = "ED4A18"
const MID_HP_COLOR = "EEAA18"
const HIG_HP_COLOR = "31DB1A"

func _ready():
	set_process(true)

func _process(delta):
	update()

func _draw():
	draw_rect(Rect2(Vector2(-30,0), Vector2(60*(float(get_parent().hp)/float(get_parent().max_hp)),10)), Color(HIG_HP_COLOR))