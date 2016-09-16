
extends Node2D

onready var meteor = get_node("meteor")
onready var meteor1 = get_node("meteor1")
onready var meteor2 = get_node("meteor2")
onready var meteor3 = get_node("meteor3")

onready var player = get_node("player")
onready var player1 = get_node("player1")
onready var player2 = get_node("player2")
onready var player3 = get_node("player3")

func _ready():
	pass

func start ():
	player.play("rain")
	meteor.show()
	player1.play("rain")
	meteor1.show()
	player2.play("rain")
	meteor2.show()
	player3.play("rain")
	meteor3.show()

func _on_player_finished():
	meteor.hide()


func _on_player1_finished():
	meteor1.hide()


func _on_player2_finished():
	meteor2.hide()


func _on_player3_finished():
	meteor3.hide()
