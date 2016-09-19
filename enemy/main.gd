
extends Node2D

var _action = "move"
var hp = 100
var max_hp = 100
var damage = 5

var current_target = null

var is_enemy = true
var slot = 0
var _death_in_progress = false

func _ready():
	set_process(true)

func _get_target():
	if current_target:
		return current_target
		
	var target = null
	if world.slots_units["11"]:
		target = world.slots_units["11"]
	elif world.slots_units["12"]:
		target = world.slots_units["12"]
	elif world.slots_units["13"]:
		target = world.slots_units["13"]
	elif world.slots_units["14"]:
		target = world.slots_units["14"]
	elif world.slots_units["15"]:
		target = world.slots_units["15"]
	
	current_target = target
	return current_target

func _process(delta):
	var animator = get_node("animator")
	
	if not world.clutch or (not world.clutch and _death_in_progress):
		var pos = get_pos()
		var s = world.slots_position[slot]
		set_pos(pos+Vector2(-100*delta, 0))
	
	if animator.is_playing() and animator.get_current_animation() != "run":
		return
	
	if world.clutch and animator:
		var target = _get_target()
		animator.play("attack")
		
		damage = rand_range(damage-2, damage+2)
		target.hp -= damage
		
		target.get_node("Label").set_text(str(round(damage)))
		target.get_node("textanimator").play("textanimation")
		
		if target.hp <= 0:
			target.hp = 0
			target.death()
	else:
		if not animator.is_playing() and animator.get_current_animation() != "run":
			animator.play("run")
	
	
func _on_collider_area_enter( area ):
	var target = area.get_parent()
	
	if target.is_enemy:
		return
		
	_action = "attack"

func death():
	get_node("move").hide()
	get_node("death").show()
	get_node("attack").hide()
	get_node("animator").play("death")
	if _death_in_progress:
		return
	_action = "death"
	_death_in_progress = true
	
func _on_textanimator_finished():
	pass

func _on_Area2D_area_enter( area ):
	if area.get_parent().is_enemy:
		return
	
	var target = area.get_parent()
	
	if get_node("animator").get_current_animation() == "death":
		return
	
	get_node("move").hide()
	get_node("death").hide()
	get_node("attack").show()
	
	get_node("animator").play("attack")
	_action = "attack"


func _on_animator_finished():
	if get_node("animator").get_current_animation() == "death":
		queue_free()
	var target = null
