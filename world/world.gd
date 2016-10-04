
extends Node2D

var _need_scroll = false
var _last_spawn = OS.get_unix_time()

export var enemy_spawn_delay = 20
onready var units_layer = get_node("units")
onready var ui = get_node("ui")

var scene = load("res://jugg/jugg.tscn")
var unit = load("res://unit/sprite_unit.tscn")
var mage = load("res://mage/mage.tscn")
var ability_button = load("res://ui/ability_button.tscn")
var rain_scene = load("res://mage/meteor.tscn")
var rain = null

var clutch = false
var wave = 0

var slots_position = {
	"11": Vector2(0, -50),
	"12": Vector2(25, 0),
	"13": Vector2(0, 50),
	"14": Vector2(-150, -15),
	"15": Vector2(-150, 35),
	
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
	pass
	
func start():
	set_process(true)
	spawn_hero("warrior")
	spawn_hero("warrior")
	spawn_hero("warrior")
	spawn_hero("mage")
	spawn_hero("priest")
	rain = rain_scene.instance()
	add_child(rain)
	
func stop():
	set_process(false)

func _process(delta):
	var now = OS.get_unix_time()
	
	if slots_units["21"] or slots_units["22"] or slots_units["23"] or slots_units["24"] or slots_units["25"]:
		return
	
	if _last_spawn + enemy_spawn_delay <= now:
		spawn_enemy()
		spawn_enemy()
		spawn_enemy()
		wave += 1

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
	enemy.hp = 100 + wave*50
	enemy.max_hp = 100 + wave*50
	slots_units[slot] = enemy
	units_layer.add_child(enemy)
	
	_last_spawn = now

func spawn_hero(type):
	var now = OS.get_unix_time()
	
	var hero = null
	if type == "warrior":
		hero = unit.instance()
	if type == "mage":
		hero = mage.instance()
		hero.set_scale(Vector2(2,2))
		hero.ability = "meteor"
		hero.get_node("body").set_modulate(Color("ED3B18"))
	if type == "priest":
		hero = mage.instance()
		hero.set_scale(Vector2(2,2))
		hero.get_node("body").set_modulate(Color("31ED18"))
	
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
	
	# button
	create_hero_button(hero)

func create_hero_button(hero):
	var button = ability_button.instance()
	button.set_text(hero.ability)
	button.hero = hero
	ui.ability_buttons.add_child(button)
	button.connect("cast_spell",self,"_on_spell_click",[hero])

func _on_spell_click (who, hero):
	if who.energy < 50:
		return
		
	if who.ability == "slam":
		return
		
	who.energy -= 50
	who.get_node("player").play(who.ability)
	
	if who.ability == "meteor":
		rain.start()
		if slots_units["25"]:
			slots_units["25"].hp -= 50
			if slots_units["25"].hp <= 0:
				slots_units["25"].death()
		if slots_units["24"]:
			slots_units["24"].hp -= 50
			if slots_units["24"].hp <= 0:
				slots_units["24"].death()
		if slots_units["23"]:
			slots_units["23"].hp -= 50
			if slots_units["23"].hp <= 0:
				slots_units["23"].death()
		if slots_units["22"]:
			slots_units["22"].hp -= 50
			if slots_units["22"].hp <= 0:
				slots_units["22"].death()
		if slots_units["21"]:
			slots_units["21"].hp -= 50
			if slots_units["21"].hp <= 0:
				slots_units["21"].death()
	
	if who.ability == "all_heal":
		if slots_units["15"]:
			if slots_units["15"].hp + 50 > slots_units["15"].max_hp:
				slots_units["15"].hp = slots_units["15"].max_hp
			else:
				slots_units["15"].hp += 50
			slots_units["15"].get_node("healanimator").play("heal")
		if slots_units["14"]:
			if slots_units["14"].hp + 50 > slots_units["14"].max_hp:
				slots_units["14"].hp = slots_units["14"].max_hp
			else:
				slots_units["14"].hp += 50
			slots_units["14"].get_node("healanimator").play("heal")
		if slots_units["13"]:
			if slots_units["13"].hp + 50 > slots_units["13"].max_hp:
				slots_units["13"].hp = slots_units["13"].max_hp
			else:
				slots_units["13"].hp += 50
			slots_units["13"].get_node("healanimator").play("heal")
		if slots_units["12"]:
			if slots_units["12"].hp + 50 > slots_units["12"].max_hp:
				slots_units["12"].hp = slots_units["12"].max_hp
			else:
				slots_units["12"].hp += 50
			slots_units["12"].get_node("healanimator").play("heal")
		if slots_units["11"]:
			if slots_units["11"].hp + 50 > slots_units["11"].max_hp:
				slots_units["11"].hp = slots_units["11"].max_hp
			else:
				slots_units["11"].hp += 50
			slots_units["11"].get_node("healanimator").play("heal")
