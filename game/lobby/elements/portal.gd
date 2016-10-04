
extends Node2D

func _ready():
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

func _process(delta):
	update()
	
func _draw():
	var p1 = Vector2(0, 0)
	var p2 = Vector2(200, 0)
	var p3 = Vector2(200, 200)
	var p4 = Vector2(0, 200)

	draw_line(p1, p2, Color("B4B43C"), 1.0)
	draw_line(p2, p3, Color("B4B43C"), 1.0)
	draw_line(p3, p4, Color("B4B43C"), 1.0)
	draw_line(p4, p1, Color("B4B43C"), 1.0)


func _input(event):
    print (event)