extends Node2D

var current_scene = null

var lobby_scene = "res://game/lobby/lobby.tscn"
var battle_scene = "res://game/battle/battle.tscn"
var map_scene = "res://game/map/map.tscn"

var lobby = null
var battle = null
var map = null

var map_points = [
	{"id": 1, "position": Vector2(145, 135), "status": 1},
	{"id": 2, "position": Vector2(190, 350), "status": -1},
	{"id": 3, "position": Vector2(300, 460), "status": -1},
	{"id": 4, "position": Vector2(340, 170), "status": -1},
	{"id": 5, "position": Vector2(490, 170), "status": -1},
	{"id": 6, "position": Vector2(540, 245), "status": -1},
	{"id": 7, "position": Vector2(580, 450), "status": -1},
]

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
	goto_scene(lobby_scene)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
	current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	
	get_tree().set_current_scene( current_scene )
	
func click_portal():
	goto_scene(map_scene)

func to_lobby():
	goto_scene(lobby_scene)