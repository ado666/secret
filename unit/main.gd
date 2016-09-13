
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var _action = "move"
var hp = 120
var max_hp = 120
var damage = 30

var target = null

func _ready():
	set_process(true)
	
func _process(delta):
	
	if _action == "attack":
		world._need_scroll = false
		return
	
	var pos = self.get_pos()
	if (pos.x<500):
		world._need_scroll = false
		self.set_pos(self.get_pos()+Vector2(100*delta,0))
	else:
		world._need_scroll = true


func _on_Area2D_area_enter( area ):
	_action = "attack"
	target = area.get_parent()
	get_node("animator").play("attack")
	
func _on_AnimationPlayer_finished():
	if _action == "attack" and target:
		if target.hp > 0:
			get_node("animator").play("attack")
			damage = rand_range(damage-5, damage+5)
			target.hp -= damage
			var energy = ui.get_node("energy")
			energy.set_value(energy.get_value()+damage/4)
			target.get_node("Label").set_text(str(round(damage)))
			target.get_node("textanimator").play("textanimation")
			if target.hp < 0:
				target.hp = 0
			if target.hp <= 0:
				target.death()
				_action = "move"
				get_node("animator").play("run")
				target = null
				return
		else:
			_action = "move"
			get_node("animator").play("run")
			target = null
	