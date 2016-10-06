
extends Node2D

onready var listener = get_node("listener")

func _ready():
	listener.set_size(get_viewport().get_rect().size)

func _draw():
	var size = get_viewport().get_rect().size
	
	draw_rect(Rect2(Vector2(0,0), size), Color("000000"))


