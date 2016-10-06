extends Node2D

func _ready():
	print ("init utils")

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
