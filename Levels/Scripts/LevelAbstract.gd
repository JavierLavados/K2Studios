extends Node2D

var playerU
var playerD
var playerL
var playerR
var interface
var background

var current
var players = []
var ids = []
var lever
var diff_lever = false
var lever_restriction = [0,0,0,0]
var buttons = [0,0,0,0]
var ready = 0
var alt_select = false
var blocks
	
func activateBlocks(id):
	for block in blocks:
		if block.id != current:
			# Rectifica la posicion del bloque
			block.position.x = int(block.position.x)
			block.set_physics_process(false)
		else:
			block.set_physics_process(true)

func wakeUp(id):
	players[current].awake = false
	current = id
	players[current].awake = true
	activateBlocks(current)
	
func gameOver():
	get_tree().reload_current_scene()

func setUp(n_players, init_lever=4):
	
	lever = init_lever
	if lever != 4:
		diff_lever = true
	for i in range(n_players):
		players.append(get_child(i))
		ids.append(get_child(i).id)
	interface = get_child(n_players)
	background = get_child(n_players+1)
	
	players[0].awake = true
	current = ids[0]
	
	blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		if block.id != current:
			block.set_physics_process(false)

func level(n_players, next_level):

	if Input.is_action_pressed("reset"):
		gameOver()
	
	if alt_select:
		if Input.is_action_just_pressed("ui_right") and players[current].is_on_floor() and 1 in ids:
			players[current].awake = false
			current = (current + 1)%4
			players[current].awake = true
			activateBlocks(current)
		
		if Input.is_action_just_pressed("ui_left") and players[current].is_on_floor() and 3 in ids:
			players[current].awake = false
			if current == 0:
				current = 3
			else:
				current -= 1
			players[current].awake = true
			activateBlocks(current)
	
	else:
		if Input.is_action_just_pressed("ui_up") and players[current].is_on_floor() and 0 in ids:
			wakeUp(0)

		if Input.is_action_just_pressed("ui_right") and players[current].is_on_floor() and 1 in ids:
			wakeUp(1)
			
		if Input.is_action_just_pressed("ui_down") and players[current].is_on_floor() and 2 in ids:
			wakeUp(2)
			
		if Input.is_action_just_pressed("ui_left") and players[current].is_on_floor() and 3 in ids:
			wakeUp(3)
	
	interface.active = current
			
	if Input.is_action_just_pressed("change_controls"):
		for p in players:
			p.cherry_controls = !p.cherry_controls
		interface.cherry_controls = !interface.cherry_controls
		
	if Input.is_action_just_pressed("change_select"):
		alt_select = !alt_select
	
	if ready == n_players:
		get_tree().change_scene(next_level)
