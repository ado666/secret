
extends Node2D

var ability = "slam"
var _action = "move"
var hp = 120
var max_hp = 120
var damage = 30
var energy = 0
var energy_max = 100

var is_enemy = false
var slot = 0

var current_target = null
var current_target_path = null

func _ready():
	set_process(true)

func _get_target():
	if current_target and world.get_node("units").has_node(current_target_path):
		return current_target
		
	var target = null
	if world.slots_units["21"]:
		target = world.slots_units["21"]
	elif world.slots_units["22"]:
		target = world.slots_units["22"]
	elif world.slots_units["23"]:
		target = world.slots_units["23"]
	elif world.slots_units["24"]:
		target = world.slots_units["24"]
	elif world.slots_units["25"]:
		target = world.slots_units["25"]
		
	if not target:
		return
	
	current_target = target
	current_target_path = current_target.get_path()
	return current_target

func _process(delta):
	#position
	var s = world.slots_position[slot]
	
	var pos = self.get_pos()
	if pos.x < 400 + s.x:
		world._need_scroll = false
		self.set_pos(self.get_pos()+Vector2(100*delta,0))
	else:
		world._need_scroll = true
	#end
	
	var animator = get_node("animator")
	if animator.is_playing() and animator.get_current_animation() != "run":
		return
	
	if world.clutch :
		var target = _get_target()
		
		if not target:
			world.clutch = false
			return
		
		animator.play("attack")
		
		damage = rand_range(damage-5, damage+5)
		if not world.get_node("units").has_node(current_target_path):
			return
		target.hp -= damage
		
		energy += damage/2
		if energy > energy_max:
			energy = energy_max
		
		target.get_node("Label").set_text(str(round(damage)))
		target.get_node("textanimator").play("textanimation")
		
		if target.hp <= 0:
			world.slots_units[target.slot] = null
			target.hp = 0
			target.death()
			current_target = null
			current_target_path = null
	else:
		if not animator.is_playing() and animator.get_current_animation() != "run":
			animator.play("run")
	
	if _action == "attack":
		world._need_scroll = false
		return
	
	


func _on_Area2D_area_enter( area ):
	if not area.get_parent().is_enemy or area.get_parent()._action != "attack":
		return
		
	world.clutch = true
		
func _on_textanimator_finished():
	pass