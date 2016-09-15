
extends Node2D

var _need_scroll = false
var _last_spawn = OS.get_unix_time()

export var enemy_spawn_delay = 20
onready var units_layer = get_node("units")

var scene = load("res://jugg/jugg.tscn")
var unit = load("res://unit/sprite_unit.tscn")

var clutch = false

var slots_position = {
	"11": Vector2(0, -50),
	"12": Vector2(25, 0),
	"13": Vector2(0, 50),
	
	"21": Vector2(0, -50),
	"22": Vector2(-20, 0),
	"23": Vector2(0, 50),
}

var slots_units = {
	"11": null,
	"12": null,
	"13": null,
	"14": null,
	"15": null,
	
	"21": null,
	"22": null,
	"23": null,
	"24": null,
	"25": null,
}


func _ready():
	set_process(true)
	spawn_hero()
	spawn_hero()
	spawn_hero()

func _process(delta):
	var now = OS.get_unix_time()
	
	if slots_units["21"] or slots_units["22"] or slots_units["23"] or slots_units["24"] or slots_units["25"]:
		return
	
	if _last_spawn + enemy_spawn_delay <= now:
		spawn_enemy()
		spawn_enemy()
		spawn_enemy()

func spawn_enemy():
	var now = OS.get_unix_time()
	
	var enemy = scene.instance()
	
	if not units_layer:
		return
	
	var slot = null
	if not slots_units["25"]:
		slot = "25"
	if not slots_units["24"]:
		slot = "24"
	if not slots_units["23"]:
		slot = "23"
	if not slots_units["22"]:
		slot = "22"
	if not slots_units["21"]:
		slot = "21"
		
	enemy.set_pos(Vector2(1200, 460) + slots_position[slot])
	enemy.set_scale(Vector2(1.5,1.5))
	
	enemy.slot = slot
	slots_units[slot] = enemy
	units_layer.add_child(enemy)
	
	_last_spawn = now

func spawn_hero():
	var now = OS.get_unix_time()
	
	var hero = unit.instance()
	
	if not units_layer:
		return
	
	var slot = null
	if not slots_units["15"]:
		slot = "15"
	if not slots_units["14"]:
		slot = "14"
	if not slots_units["13"]:
		slot = "13"
	if not slots_units["12"]:
		slot = "12"
	if not slots_units["11"]:
		slot = "11"
		
	hero.set_pos(Vector2(260, 460) + slots_position[slot])
	
	hero.slot = slot
	slots_units[slot] = hero
	units_layer.add_child(hero)

