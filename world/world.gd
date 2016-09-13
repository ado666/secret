
extends Node2D

var _need_scroll = false
var _last_spawn = OS.get_unix_time()

export var enemy_spawn_delay = 20
onready var units_layer = get_node("units")

var scene = load("res://jugg/jugg.tscn")


func _ready():
	set_process(true)
	print(111)

func _process(delta):
	var now = OS.get_unix_time()
	
	if _last_spawn + enemy_spawn_delay <= now:
		spawn_enemy()

func spawn_enemy():
	var now = OS.get_unix_time()
	
	
	var enemy = scene.instance()
	
	if not units_layer:
		return
	enemy.set_pos(Vector2(1200, 460))
	enemy.set_scale(Vector2(1.5,1.5))
	
	units_layer.add_child(enemy)
	
	_last_spawn = now
	

