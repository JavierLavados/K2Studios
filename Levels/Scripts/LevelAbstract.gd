extends Node2D

onready var interface = $Interface
onready var background =$Background
onready var timer = $Timer

#var music

var current #Almacena el id del jugador actual
var players = []
var ids = []
var lever
var diff_lever = false
var lever_restriction = [0,0,0,0]
var button_restriction = [0,0,0,0]
var buttons = [0,0,0,0]
var ready = 0

var alt_select 
var cherry_controls

var blocks
var clouds
var switch_restriction = 0
var freeze_players = 0

# para el selector	
var completed 
export var int_level=1

func _ready():
	cherry_controls = Globals.current_settings[0]
	alt_select = Globals.current_settings[1]
	
	timer.set_paused(true)
	timer.one_shot = true
	#music.play_music()
			
##################


func activateBlocks(prev, new):
	for block in blocks:
		if block.id != current:
			# Rectifica la posicion del bloque
			block.position.x = int(round(block.position.x))
			block.position.y = int(round(block.position.y))
		if block.id == prev:
			block.counter += 1
		if block.id == new:
			block.counter -= 1

func wakeUp(prev, new):
	players[ids.find(current)].awake = false
	current = new
	players[ids.find(current)].awake = true
	for cloud in clouds:
		if cloud.respawn_restriction == 0:
			cloud.disabled = false
	activateBlocks(prev, new)
	
func gameOver():
	get_tree().reload_current_scene()

func setUp(n_players, init_lever=4,music=null):
	#music=get_node(music)
	#music.play_music()
	
	lever = init_lever
	if lever != 4:
		diff_lever = true
		
	for i in range(n_players):
		players.append(get_child(i))
		ids.append(get_child(i).id)
	
	players[0].awake = true
	current = ids[0]
	
	blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		if block.id != current:
			block.set_physics_process(false)
			block.counter = 1
			
	clouds = get_tree().get_nodes_in_group("Clouds")

func level(n_players):
	var prev_cherry_controls =  cherry_controls
	var c_index = ids.find(current)
	
	cherry_controls = Globals.current_settings[0]
	alt_select = Globals.current_settings[1]

	if Input.is_action_pressed("reset"):
		gameOver()
		
	if freeze_players:
		for p in players:
			p.freeze = true
	else:
		for p in players:
			p.freeze = false
		
	if switch_restriction == 0:

		if alt_select:
			if Input.is_action_just_pressed("ui_right") and players[c_index].is_on_floor() and len(ids) > 1:
				var prev = current
				players[ids.find(current)].awake = false
				for i in range(3):
					if (current + i + 1)%4 in ids:
						current = (current + i + 1)%4
						break
				players[ids.find(current)].awake = true
				activateBlocks(prev, current)
			
			if Input.is_action_just_pressed("ui_left") and players[c_index].is_on_floor() and len(ids) > 1:
				var prev = current
				players[ids.find(current)].awake = false
				for i in range(3):
					if (current - i + 3)%4 in ids:
						current = (current - i + 3)%4
						break
				players[ids.find(current)].awake = true
				activateBlocks(prev, current)
		
		else:
			if current != 0 and Input.is_action_just_pressed("ui_up") and players[c_index].is_on_floor() and 0 in ids:
				wakeUp(current,0)

			if current != 1 and  Input.is_action_just_pressed("ui_right") and players[c_index].is_on_floor() and 1 in ids:
				wakeUp(current,1)
				
			if current != 2 and  Input.is_action_just_pressed("ui_down") and players[c_index].is_on_floor() and 2 in ids:
				wakeUp(current,2)
				
			if current != 3 and Input.is_action_just_pressed("ui_left") and players[c_index].is_on_floor() and 3 in ids:
				wakeUp(current,3)
	
	interface.active = current
			
	if prev_cherry_controls!=cherry_controls:
		for p in players:
			p.cherry_controls = !p.cherry_controls
		interface.cherry_controls = !interface.cherry_controls
		
	#if Input.is_action_just_pressed("change_controls"):
		#for p in players:
		#	p.cherry_controls = !p.cherry_controls
		#interface.cherry_controls = !interface.cherry_controls
		
	#if Input.is_action_just_pressed("change_select"):
		#alt_select = !alt_select
	
	if ready == n_players:
		if timer.is_paused():
			timer.start(3.0)
			timer.set_paused(false)	
		if timer.time_left <= 0:
			completed = Globals.levels_status[int_level-1]
			if not completed :
				Globals.current_points+=1
				Globals.levels_status[int_level-1]=true
			get_tree().change_scene("res://MapInterface/WorldMaps/WorldMaps.tscn")
