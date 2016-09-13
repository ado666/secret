
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var _action = "move"
var hp = 100
var max_hp = 100
var damage = 10
var target = null

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	
	if _action != "move" && _action != "death" && _action != "death_end":
		return
	
	var pos = get_pos()
	set_pos(pos+Vector2(-100*delta, 0))
	
func _on_collider_area_enter( area ):
	#pass
	#get_node("AnimationPlayer").play("attack")
	_action = "attack"

func death():
	_action = "death"

func _on_Area2D_area_enter( area ):
	get_node("move").hide()
	get_node("death").hide()
	get_node("attack").show()
	
	target = area.get_parent()
	get_node("animator").play("attack")
	_action = "attack"


func _on_animator_finished():
	
	if _action == "attack" and target:
		if target.hp > 0:
			get_node("animator").play("attack")
			damage = rand_range(damage-2, damage+2)
			target.hp -= damage
			target.get_node("Label").set_text(str(round(damage)))
			target.get_node("textanimator").play("textanimation")
			if target.hp < 0:
				target.hp = 0
			if target.hp <= 0:
				#target.death()
				_action = "move"
				#get_node("animator").play("run")
				target = null
				return
	
	if _action == "death_end":
		queue_free()
		return
	
	if _action == "death":
		get_node("move").hide()
		get_node("death").show()
		get_node("attack").hide()
		get_node("animator").play("death")
		_action = "death_end"
