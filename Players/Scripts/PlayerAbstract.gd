extends KinematicBody2D

# Constantes
const MAX_SPEED = 96
const AIR_SPEED = 112
const AIR_SPEED_2 = 144
const JUMP_H = 375
const JUMP_H_2 = 325
const TRAMPOLINE_H = 750
const CLIMB_SPEED = 96
const gravity = 25

# Variables para debugging
export var auto_jump = false
export var see_controllable = false
export var teleport = false

# Referencias a otros nodos
onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var playback = $AnimTree.get("parameters/playback")
onready var left_pos = $Left
onready var right_pos = $Right
onready var ray = $RayCast2D
onready var area = $Area2D

# Variables auxiliares
var InvisiWall
var awake = false
var controllable = true
var jumping = false
var was_on_floor = false
var on_ladder = 0
var detector_pos = null
var climbing = 0
var air_jump_used = false
var doubleJump = false
var pushing = false
var align = 0
var exit = false
var freeze = false
var trampoline = false

var rot
var invisiWallL
var invisiWallR
var id
var floored
var t_jump = false

var Air = preload("res://Powerups/Air.tscn")

var default_texture
var boots_texture

var motion = Vector2()

func initialize(n, wall):
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		add_collision_exception_with(player)
	rot = -rad2deg(n.angle_to(Vector2(0,-1)))
	sprite.rotation_degrees = rot
	sprite.texture = load(default_texture)
	InvisiWall = wall
	
func modify_sprite(n, forward, backward):
	var left = n.rotated(deg2rad(90))
	var side_motion = int(left.dot(motion))
	var climb_motion = int(n.dot(motion))
	var flip = false
	if n.x < 0 or n.y > 0:
		flip = true

	if doubleJump:
		sprite.texture = load(boots_texture)
	else:
		sprite.texture = load(default_texture)

	if awake:
		if Input.is_action_just_pressed(forward):
			if flip:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		if Input.is_action_just_pressed(backward):
			if flip:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
				
	if exit:
		playback.travel("Exit")
	else:
		if not awake:
			playback.travel("Sleeping")
		else:
			if side_motion != 0:
				playback.travel("Walk")
			else:
				playback.travel("Idle")

			if pushing:
				playback.travel("Push")

	if climbing == 1:
		if climb_motion != 0:
			playback.travel("Climb")
		else:
			playback.travel("ClimbIdle")
			

# FUNCION PRINCIPAL
func calc_motion(n, forward, backward, top, btm):
	
	collision.rotation_degrees = rot
	if awake:
		collision.shape.extents.y = 7.8
		if n.x == 0:
			collision.position.y = -0.1*n.y
		else:
			collision.position.x = -0.1*n.x
	else:
		collision.shape.extents.y = 6
		if n.x == 0:
			collision.position.y = -4*n.y 
		else:
			collision.position.x = -4*n.x 
				
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
	floored = on_floor
	
	if on_floor:
		jumping = false
		controllable = true
		air_jump_used = false
		t_jump = false
		if is_instance_valid(invisiWallL):
			invisiWallL.queue_free()
			invisiWallR.queue_free()
	
	# Aceleracion de gravedad hasta cierto punto
	if motion.dot(n) > -JUMP_H and not climbing:
		if not t_jump:
			motion += -gravity * n
		else:
			if motion.y <= 0:
				motion += -gravity * n
			else:
				motion += -10 * n
		
	# Inputs del teclado
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	var vertical_vel = Input.get_action_strength(btm) - Input.get_action_strength(top)

	# Movimiento vertical (salto)
	var on_edge = !ray.is_colliding() and on_floor

	if Input.is_action_just_pressed("ui_accept") and awake and not climbing:
		
		# Posicionamiento de paredes invisibles
		var relative_pos = Vector2(int(global_position.x)%32-15,int(global_position.y)%32-15)
		
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
			
			var air = Air.instance()
			get_parent().add_child(air) 
			air.global_position = global_position
			air.rotation_degrees = rot
			air.movement = n

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
			if trampoline:
				motion = n * TRAMPOLINE_H
				t_jump = true
			else:
				motion = n * JUMP_H
			jumping = true
			
			# Creacion paredes invisibles
			invisiWallL = InvisiWall.instance()
			invisiWallR = InvisiWall.instance()
			get_parent().add_child(invisiWallL) 
			get_parent().add_child(invisiWallR) 
			invisiWallL.global_position = left_pos.global_position
			invisiWallR.global_position = right_pos.global_position
			if t_jump:
				invisiWallL.scale.y *= 3
				invisiWallR.scale.y *= 3
				invisiWallL.global_position.x -= 64
				invisiWallR.global_position.x += 64
				invisiWallL.global_position.y += 16
				invisiWallR.global_position.y += 16
				
	# AUTO JUMP PARA DEBUGGING
	if was_on_floor and not on_floor and auto_jump:
		motion = n * JUMP_H
		jumping = true
	
	# CASOS DE INCONTROLABILIDAD
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso salto con caida libre
	#if t_jump:
	#	if motion.dot(n) <= -TRAMPOLINE_H:
	#		controllable = false
	#else:
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

	# Calculo variables de escalera		
	if awake:
		
		var tile_pos
		if n.x == 0:
			tile_pos = int(position.x-16)%32
		else:
			tile_pos = int(position.y-16)%32

		if on_ladder <= 0 or on_floor:
			climbing = 0
			
		if align != 0 and tile_pos == 0:
			align = 0
			
		var same_height = false
		if detector_pos:
			if n.x == 0:
				if position.y-5 < detector_pos[0][1] and position.y+5 > detector_pos[0][1]:
					same_height = true
			else:
				if position.x-5 < detector_pos[0][0] and position.x+5 > detector_pos[0][0]: 
					same_height = true
			
		if on_floor and same_height and vertical_vel == detector_pos[1]:
			if tile_pos != 0:
				if align == 0:
					if n.x == 0:
						if position.x < detector_pos[0][0]:
							align = 1
						else:
							align = -1
					else:
						if position.y < detector_pos[0][1]:
							align = 1
						else:
							align = -1
						
			else:
				if vertical_vel == detector_pos[1]:
					if target_vel != 0:
						target_vel = 0
					if n.x == 0: 
						motion.y = vertical_vel * CLIMB_SPEED
					else:
						motion.x = vertical_vel * CLIMB_SPEED
					if detector_pos[2]:
						climbing = 1
					else:
						climbing = -1
		
		if climbing == 1:
			if n.x == 0:
				motion.y = vertical_vel * CLIMB_SPEED
			else:
				motion.x = vertical_vel * CLIMB_SPEED

	# Calculo movimiento horizontal
	if n.x == 0:
		if on_floor:
			motion.x = target_vel * MAX_SPEED
		else:
			if air_jump_used:
				motion.x = target_vel * AIR_SPEED_2
			else:
				motion.x = target_vel * AIR_SPEED
		if freeze or not awake:
			motion.x = 0
		if align != 0:
			motion.x = align * 32
	else:
		if on_floor:
			motion.y = target_vel * MAX_SPEED
		else:
			if air_jump_used:
				motion.y = target_vel * AIR_SPEED_2
			else:
				motion.y = target_vel * AIR_SPEED
		if freeze or not awake:
			motion.y = 0
		if align != 0:
			motion.y = align * 32
								
	if exit or playback.get_current_node() == "Return":
		if n.x == 0:
			motion.x = 0
			motion.y = -n.y
		else:
			motion.x = -n.x
			motion.y = 0
		
	# Movimiento final
	motion = move_and_slide(motion, n)
	
	# TELETRANSPORTACION PARA DEBUGGING	
	if Input.is_action_just_pressed("teleport") and teleport and awake:
		global_position = get_global_mouse_position()
	
	modify_sprite(n, forward, backward)
