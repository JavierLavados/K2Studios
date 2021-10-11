extends KinematicBody2D

# Constantes
const MAX_SPEED = 96
const AIR_SPEED = 112
const AIR_SPEED_2 = 144
const JUMP_H = 375
const JUMP_H_2 = 325
const gravity = 25

# Variables para debugging
export var auto_jump = false
export var see_controllable = false
export var teleport = false

# Referencias a otros nodos
onready var sprite = $Sprite
onready var animationPlayer = $Default
onready var animationTree = $AnimationTree
onready var playback = $AnimationTree.get("parameters/playback")
onready var collision = $CollisionShape2D
onready var ladder_detector = $ladder_detector
onready var left_pos = $Left
onready var right_pos = $Right
onready var ray = $RayCast2D

# Variables auxiliares
var InvisiWall
var awake = false
var controllable = true
var jumping = false
var was_on_floor = false
var on_ladder = false
var air_jump_used = false
var doubleJump = false

var rot
var invisiWallL
var invisiWallR

var motion = Vector2()

func initialize(n, wall):
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		add_collision_exception_with(player)
	rot = -rad2deg(n.angle_to(Vector2(0,-1)))
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot
	InvisiWall = wall
	
func modify_sprite(n, forward, backward):
	var left = n.rotated(deg2rad(90))
	var side_motion = int(left.dot(motion))
	var flip = false
	if n.x < 0 or n.y > 0:
		flip = true
	
	if doubleJump:
		$AnimationTree.anim_player = "../Boots"
	else:
		$AnimationTree.anim_player = "../Default"
	
	if awake:
		if Input.is_action_just_pressed(forward):
			if flip:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
			#ladder_detector.scale.x = 1
		if Input.is_action_just_pressed(backward):
			if flip:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
			#ladder_detector.scale.x = -1
			
	if not awake:
		playback.travel("Sleeping")
	else:
		if side_motion != 0:
			playback.travel("Walk")
		else:
			playback.travel("Idle")
	
# GENERALIZAR PARA TODOS
func is_on_ladder():
	var areas = ladder_detector.get_overlapping_areas()
	if areas.size() > 0:
		for area in areas:
			if "ladder".to_upper() in area.name.to_upper():
				on_ladder = area.get_parent().position
	else:
		on_ladder = false
	return on_ladder
	
#func check_block_collision(hspd, collisions):
#	for i in collisions:
#		var block : = get_slide_collision(i).collider as Block
#		if block:
#			block.push(hspd)
			
			
			
# FUNCION PRINCIPAL
func calc_motion(n, forward, backward, top, btm):

	# Calculo para colision con puas 
	# (generalizar para otros elementos peligrosos)
	for i in get_slide_count():
		var coll = get_slide_collision(i)
		if is_instance_valid(coll.collider):
			if coll.collider.is_in_group("Spikes"): 
				if coll.collider.NORMAL == coll.normal:
					get_parent().gameOver()
					
	# Reseteo de variables al estar en el piso
	var on_floor = is_on_floor()
	
	if on_floor:
		jumping = false
		controllable = true
		air_jump_used = false
		if is_instance_valid(invisiWallL):
			invisiWallL.queue_free()
			invisiWallR.queue_free()
	
	# Aceleracion de gravedad hasta cierto punto
	if motion.dot(n) > -JUMP_H:
		motion += -gravity * n
		
	# Inputs del teclado
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	var vertical_vel = Input.get_action_strength(top) - Input.get_action_strength(btm)

	# Movimiento vertical (salto)
	if Input.is_action_just_pressed("ui_accept") and awake:
		
		# Posicionamiento de paredes invisibles
		var relative_pos = Vector2(int(global_position.x)%32-15,int(global_position.y)%32-15)
		var on_edge = !ray.is_colliding() and on_floor
		
		var l_val = 95
		var r_val = 97
		
		if (on_edge and not jumping):
			if n.x == 0:
				if relative_pos.x > 0:
					l_val = 63
				else:
					r_val = 65
			else:
				if relative_pos.y > 0:
					l_val = 63
				else:
					r_val = 65
		
		if n.x == 0:
			left_pos.global_position.x = int(global_position.x - l_val - relative_pos.x)
			right_pos.global_position.x = int(global_position.x + r_val - relative_pos.x)
		else:
			left_pos.global_position.y = int(global_position.y - l_val - relative_pos.y)
			right_pos.global_position.y = int(global_position.y + r_val - relative_pos.y)
		
		# Caso segundo salto
		if doubleJump and not air_jump_used and not on_floor:

			motion = n * JUMP_H_2
			jumping = true
			air_jump_used = true
			controllable = true

			# Creacion paredes invisibles
			if not is_instance_valid(invisiWallL):
				invisiWallL = InvisiWall.instance()
				invisiWallR = InvisiWall.instance()
				get_parent().add_child(invisiWallL) 
				get_parent().add_child(invisiWallR)
			invisiWallL.global_position = left_pos.global_position
			invisiWallR.global_position = right_pos.global_position	

		# Caso salto inicial
		if on_floor:
			motion = n * JUMP_H
			jumping = true
			
			# Creacion paredes invisibles
			invisiWallL = InvisiWall.instance()
			invisiWallR = InvisiWall.instance()
			get_parent().add_child(invisiWallL) 
			get_parent().add_child(invisiWallR) 
			invisiWallL.global_position = left_pos.global_position
			invisiWallR.global_position = right_pos.global_position
			
	# AUTO JUMP PARA DEBUGGING
	if was_on_floor and not on_floor and auto_jump:
		motion = n * JUMP_H
		jumping = true
		print(int(position.x+16)%32)
	
	# CASOS DE INCONTROLABILIDAD
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso salto con caida libre
	if motion.dot(n) <= -JUMP_H:
		controllable = false
		
	# Incontrolable al despertar
	if ((playback.get_current_node() == "Sleep") or (playback.get_current_node() == "WakeUp")):
		controllable = false
		
	# CAMBIO COLOR PARA DEBUGGING			
	if not controllable:
		if see_controllable:
			$Sprite.modulate = Color.blue
		target_vel = 0
	else:
		if see_controllable:
			$Sprite.modulate = Color.white
			
	# Calculo movimiento horizontal
	
	if n.x == 0:
		if on_floor:
			motion.x = target_vel * MAX_SPEED
		else:
			if air_jump_used:
				motion.x = target_vel * AIR_SPEED_2
			else:
				motion.x = target_vel * AIR_SPEED
		if not awake:
			motion.x = 0
	else:
		if on_floor:
			motion.y = target_vel * MAX_SPEED
		else:
			if air_jump_used:
				motion.y = target_vel * AIR_SPEED_2
			else:
				motion.y = target_vel * AIR_SPEED
		if not awake:
			motion.y = 0
				
	if n == Vector2(0, -1):
		# Interaccion con escaleras
		is_on_ladder()
		if on_ladder and Input.is_action_pressed(top):
			if n.x == 0:
				if position.x != on_ladder.x:
					position.x = on_ladder.x
			else:
				if position.y != on_ladder.y:
					position.y = on_ladder.y
		
		# Empujar cajas:
		#var count = get_slide_count()
		#if count > 1:
		#	if n.x == 0:
		#		check_block_collision(motion.x, count)
		#	else:
		#		check_block_collision(motion.y, count)

	# Movimiento final
	motion = move_and_slide(motion, n)
	
	# TELETRANSPORTACION PARA DEBUGGING	
	if Input.is_action_just_pressed("teleport") and teleport and awake:
		global_position = get_global_mouse_position()
