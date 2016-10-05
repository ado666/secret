
extends Node2D

var color_close = Color("756A6A") #-1
var color_open = Color("CC2626") #0

var color_complete_1 = Color("18DF40") #1
var color_complete_2 = Color("18DF40") #2
var color_complete_3 = Color("18DF40") #3

var id = null
var idx = null
var status = -1
var current_color = color_close

func _ready():
	pass

func _draw():
	var status = global.map_points[idx].status
	if status == -1:
		current_color = color_close
	elif status == 0:
		current_color = color_open
	elif status == 1:
		current_color = color_complete_1
	elif status == 2:
		current_color = color_complete_2
	elif status == 3:
		current_color = color_complete_3
	
	draw_circle(Vector2(0,0), 25, current_color)

func set_status(s):
	global.map_points[idx].status = s
	#update()

func _on_Control_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == BUTTON_LEFT and ev.pressed:
			if global.map_points[idx].status < 0:
				return
			set_status(1)
			get_parent().update_progress()
