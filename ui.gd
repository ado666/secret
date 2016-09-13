
extends Node2D


func _ready():
	set_process(true)
	
func _process(delta):
	update()

func _on_Button_pressed():
	var unit = world.units_layer.get_node("player")
	var energy = get_node("energy")
	if energy.get_val() < 40:
		return
	
	energy.set_value(energy.get_val()-40)
	unit.hp += 30
	unit.get_node("healanimator").play("heal")