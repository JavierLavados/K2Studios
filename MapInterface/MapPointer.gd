extends Node2D

const MAX_SPEED = 240

onready var sprite = $Sprite
onready var timer = $Timer
onready var marker = $PositionMarker

var motion = Vector2(0,0) # Direccion de movimiento del marcador
var order = [0,1,2,3] # Orden en el que salen los personajes

var current_node = null # Almacena el icono del nivel actual
var directions = null # Direciones disponibles para movimiento
var current_dir = -1 # Direccion de movimiento actual, -1 si no hay movimiento
var last_dir = null # Almacena ultimo movimiento realizado
var waiting = false # Bloquea el marcador hasta que los personajes lleguen

var target_node = null # Nodo objetivo para personajes
var pending_leave = 0

var go_back = false
var leave = false

func leave_in_order(order, motion):
	for i in order:
		var guy = get_child(i)
		if not guy.left_signal:
			guy.leave_signal = true
			guy.motion = motion
		if not guy.small and guy.leave_signal:
			return true
		else:
			guy.leave_signal = false
			guy.left_signal = true
	return false
	
func _ready():
	timer.set_paused(true)
	timer.one_shot = true

func _physics_process(delta):

	if current_node:
		marker.global_position = current_node.global_position
		target_node = marker.global_position
		directions = current_node.directions
		current_node = null
		motion = Vector2(0,0)
		current_dir = -1
	
	var h_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	var v_vel = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if (h_vel != 0 or v_vel != 0) and current_dir == -1 and not waiting:
		if h_vel != 0:
			if h_vel == 1 and directions[1]:
				current_dir = 1
				last_dir = 1
				order = [0,1,2,3]
				pending_leave = 4
				waiting = true
				motion = Vector2(MAX_SPEED,0)
			if h_vel == -1 and directions[3]:
				current_dir = 3
				last_dir = 3
				order = [3,2,1,0]
				pending_leave = 4
				waiting = true
				motion = Vector2(-MAX_SPEED,0)
		if v_vel != 0:
			if v_vel == 1 and directions[2]:
				current_dir = 2
				last_dir = 2
				order = [1,3,0,2]
				pending_leave = 4
				waiting = true
				motion = Vector2(0,MAX_SPEED)
			if v_vel == -1 and directions[0]:
				current_dir = 0
				last_dir = 0
				order = [2,0,3,1]
				pending_leave = 4
				waiting = true
				motion = Vector2(0,-MAX_SPEED)

	marker.move_and_slide(motion)
	
	if pending_leave > 0:
		if pending_leave == 4 and timer.is_paused():
			timer.start(0.1)
			timer.set_paused(false)	
		if timer.time_left <= 0:
			var guy = get_child(order[4-pending_leave])
			guy.leave = 1
			if last_dir % 2 == 1:
				if last_dir == 1:
					if pending_leave % 2 == 0:
						timer.start(0.2)
					else:
						timer.start(0.15)
				else:
					if pending_leave % 2 == 0:
						timer.start(0.15)
					else:
						timer.start(0.18)
					
			else:
				timer.start(0.15)
			timer.set_paused(false)	
			pending_leave -= 1
	
	if waiting and pending_leave == 0:
		var ready = 0
		for i in range(4):
			var guy = get_child(i)
			if guy.leave == 0:
				ready += 1
		if ready == 4:
			waiting = false
			
	if go_back:
		marker.global_position = target_node
		go_back = false 
