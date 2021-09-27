extends Node2D

var playerU
var playerD
var playerL
var playerR
var interface

var current
var players
var lever

var readyUp
var readyDown
var readyLeft
var readyRight

func _ready():
	
	# Se obtienen los jugadores
	playerU = get_child(0)
	playerR = get_child(1)
	playerD = get_child(2)
	playerL = get_child(3)
	interface = get_child(4)
	
	players = [playerU, playerR, playerD, playerL]
	playerU.awake = true
	current = 0
	lever = 4
	
	readyUp=false
	
	
func _physics_process(delta):
	
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("ui_up") and players[current].is_on_floor():
		players[current].awake = false
		current = 0
		players[current].awake = true

	if Input.is_action_just_pressed("ui_right") and players[current].is_on_floor():
		players[current].awake = false
		current = 1
		players[current].awake = true
		
	if Input.is_action_just_pressed("ui_down") and players[current].is_on_floor():
		players[current].awake = false
		current = 2
		players[current].awake = true
		
	if Input.is_action_just_pressed("ui_left") and players[current].is_on_floor():
		players[current].awake = false
		current = 3
		players[current].awake = true
	
	interface.active = current
	
	readyUp=get_node("DoorUp").readyUp
	readyDown=get_node("DoorDown").readyDown
	readyLeft=get_node("DoorLeft").readyLeft
	readyRight=get_node("DoorRight").readyRight
	if readyUp and readyDown and readyLeft and readyRight:
		get_tree().change_scene("res://scenes/World2.tscn")
