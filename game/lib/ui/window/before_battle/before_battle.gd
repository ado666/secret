extends "res://game/lib/ui/window/window.gd"

func _ready():
	pass
	
func _on_complete_pressed():
	var idx = data["point_idx"]
	global.map_points[idx].status = 1
	global.current_scene.points.update_progress()
	utils.close_window(self)