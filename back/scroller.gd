
extends ParallaxLayer

func _ready():
	set_process(true)
	
func _process(delta):
	if not world._need_scroll or world.clutch:
		return
	
	var pos = self.get_pos()
	if pos.x <= -1024:
		pos.x = 0
	set_pos(pos+Vector2(-100*delta, 0))


