
extends Node2D

#onready var scene_cnt = get_node("scene_cnt")

#var current_scene = null
#onready var lobby_scene = preload("res://game/lobby/lobby.tscn")
#onready var combat_scene = preload("res://world.tscn")

func _ready():
	print ("init game")


func click_element():
	select_scene("combat")
	
func select_scene(scene):
		
	if scene == "lobby":
		get_tree().change_scene("res://game/root.tscn")
	if scene == "combat":
		get_tree().change_scene("res://world.tscn")