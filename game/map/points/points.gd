extends Node2D

onready var point_scene = preload("res://game/map/points/point/point.tscn")

var color_close = Color("756A6A") #-1
var color_open = Color("CC2626") #0

var color_complete_1 = Color("18DF40") #1
var color_complete_2 = Color("18DF40") #2
var color_complete_3 = Color("18DF40") #3

func _ready():
	init_points()

func init_points():
	var points = global.map_points
	for idx in range(points.size()):
		var point = points[idx]
		var s = point_scene.instance()
		s.set_pos(point.position)
		s.id = point.id
		s.idx = idx
		add_child(s)
		s.set_status(point.status)
	
	update_progress()
	update()
	
func update_progress():
	var points = global.map_points
	for idx in range(points.size()):
		if idx == points.size()-1:
			continue
		var p1 = points[idx]
		var p2 = points[idx+1]
		
		if p1.status > 0 and p2.status == -1:
			p2.status = 0
	
	for p in get_children():
		p.update()
	update()
	
func _draw():
	var points = global.map_points
	for idx in range(points.size()):
		if idx == 0:
			continue
		
		var p1 = points[idx-1]
		var p2 = points[idx]
		
		var status = p2.status
		var current_color = null
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
		
		draw_line(p1.position, p2.position, current_color, 3.0)


