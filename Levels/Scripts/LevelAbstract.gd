extends Node2D

var playerU
var playerD
var playerL
var playerR
var interface

var current
var players = []
var ids = []
var lever

var ready = 0

func setUp(n_players):
	for i in range(n_players):
		players.append(get_child(i))
		ids.append(get_child(i).id)
	interface = get_child(n_players)
	
	players[0].awake = true
	current = ids[0]
	lever = 4

func level(n_players, next_level):
	
	print(ready)

	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("ui_up") and players[current].is_on_floor() and 0 in ids:
		players[current].awake = false
		current = 0
		players[current].awake = true

	if Input.is_action_just_pressed("ui_right") and players[current].is_on_floor() and 1 in ids:
		players[current].awake = false
		current = 1
		players[current].awake = true
		
	if Input.is_action_just_pressed("ui_down") and players[current].is_on_floor() and 2 in ids:
		players[current].awake = false
		current = 2
		players[current].awake = true
		
	if Input.is_action_just_pressed("ui_left") and players[current].is_on_floor() and 3 in ids:
		players[current].awake = false
		current = 3
		players[current].awake = true
		
	if Input.is_action_just_pressed("change_controls"):
		for p in players:
			p.cherry_controls = !p.cherry_controls
		interface.cherry_controls = !interface.cherry_controls
	
	interface.active = current

	if ready == n_players:
		get_tree().change_scene(next_level)
