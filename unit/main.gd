
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	var pos = self.get_pos()
	if (pos.x<500):
		world._need_scroll = false
		self.set_pos(self.get_pos()+Vector2(100*delta,0))
	else:
		world._need_scroll = true


