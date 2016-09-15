
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var _action = "move"
var hp = 100
var max_hp = 100
var damage = 5
var target = null

var is_enemy = true
var slot = 0

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	
	if _action != "move" && _action != "death" && _action != "death_end":
		return
	
	var pos = get_pos()
	set_pos(pos+Vector2(-100*delta, 0))
	
func _on_collider_area_enter( area ):
	target = area.get_parent()
	
	if target.is_enemy:
		return
		
	_action = "attack"

func death():
	_action = "death"

func _on_Area2D_area_enter( area ):
	target = area.get_parent()
	
	if target.is_enemy:
		return
	
	get_node("move").hide()
	get_node("death").hide()
	get_node("attack").show()
	
	
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
				_action = "move"
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
