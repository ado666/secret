extends Node2D

var _blocker = null
var _windows = {}

func _ready():
	_windows["before_battle"] = before_battle
	_windows["checked_point"] = checked_point
	_blocker = blocker_scene.instance()
	

var map_color_close = Color("756A6A") #-1
var map_color_open = Color("CC2626") #0
var map_color_complete_1 = Color("18DF40") #1
var map_color_complete_2 = Color("18DF40") #2
var map_color_complete_3 = Color("18DF40") #3

func status_to_map_point_color(status):
	var current_color = null
	
	if status == -1:
		current_color = map_color_close
	elif status == 0:
		current_color = map_color_open
	elif status == 1:
		current_color = map_color_complete_1
	elif status == 2:
		current_color = map_color_complete_2
	elif status == 3:
		current_color = map_color_complete_3
	
	return current_color

onready var blocker_scene = preload("res://game/lib/ui/blocker/blocker.tscn")
onready var before_battle = preload("res://game/lib/ui/window/before_battle/before_battle.tscn")
onready var checked_point = preload("res://game/lib/ui/window/checked_point/checked_point.tscn")



func open_window(window, data):
	var w = _windows[window]
	w = w.instance()
	
	w.data = data
	w.set_pos(Vector2(self.get_parent().get_rect().size.width/2,self.get_parent().get_rect().size.height/2))
	
	global.current_scene.windows.add_child(_blocker)
	global.current_scene.windows.add_child(w)

func close_window(window):
	global.current_scene.windows.remove_child(_blocker)
	global.current_scene.windows.remove_child(window)