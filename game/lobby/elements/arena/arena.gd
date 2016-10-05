
extends Node2D

var colorOver = Color("B5763C")
var colorOut = Color("B4B43C")
var colorCurrent = colorOut

signal click_element_arena

func _ready():
	set_process(true)
	connect("click_element_arena", global, "click_arena")
	

func _process(delta):
	update()

func _draw():
	var p1 = Vector2(0, 0)
	var p2 = Vector2(30, 0)
	var p3 = Vector2(30, 30)
	var p4 = Vector2(0, 30)

	#draw_line(p1, p2, colorCurrent, 1.0)
	#draw_line(p2, p3, colorCurrent, 1.0)
	#draw_line(p3, p4, colorCurrent, 1.0)
	#draw_line(p4, p1, colorCurrent, 1.0)

func _on_listener_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == BUTTON_LEFT and ev.pressed:
			emit_signal("click_element_arena")

func _on_listener_mouse_enter():
	colorCurrent = colorOver


func _on_listener_mouse_exit():
	colorCurrent = colorOut
