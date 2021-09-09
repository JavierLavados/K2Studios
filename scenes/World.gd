extends Node2D

var playerU
var playerD
var playerL
var playerR

var current
var players

func _ready():
	
	# Se obtienen los jugadores
	playerU = get_child(0)
	print(playerU.name)
	playerR = get_child(1)
	print(playerR.name)
	playerD = get_child(2)
	print(playerD.name)
	playerL = get_child(3)
	print(playerL.name)
	
	players = [playerU, playerR, playerD, playerL]
	playerU.awake = true
	current = 0
	
func _physics_process(delta):

	if Input.is_action_just_pressed("ui_up") and players[current].is_on_floor():
		players[current].awake = false
		current = 0
		players[current].awake = true
		print("Cambio!")
		
	if Input.is_action_just_pressed("ui_right") and players[current].is_on_floor():
		players[current].awake = false
		current = 1
		players[current].awake = true
		print("Cambio!")
		
	if Input.is_action_just_pressed("ui_down") and players[current].is_on_floor():
		players[current].awake = false
		current = 2
		players[current].awake = true
		print("Cambio!")
		
	if Input.is_action_just_pressed("ui_left") and players[current].is_on_floor():
		players[current].awake = false
		current = 3
		players[current].awake = true
		print("Cambio!")
