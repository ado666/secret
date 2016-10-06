
extends Node2D

var id = null
var idx = null
var status = -1
var current_color = null

func _ready():
	pass

func _draw():
	var status = global.map_points[idx].status
	
	current_color = utils.status_to_map_point_color(status)
	
	draw_circle(Vector2(0,0), 25, current_color)

func set_status(s):
	global.map_points[idx].status = s

func _on_Control_input_event( ev ):
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == BUTTON_LEFT and ev.pressed:
			if global.map_points[idx].status < 0:
				return
			if global.map_points[idx].status == 0:
				utils.open_window("before_battle", {"point_idx": idx})
			else:
				utils.open_window("checked_point", {"point_idx": idx})
