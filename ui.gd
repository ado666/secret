
extends Node2D

onready var ability_buttons = get_node("ability_buttons")

func _ready():
	set_process(true)
	
func _process(delta):
	update()