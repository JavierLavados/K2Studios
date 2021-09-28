extends KinematicBody2D

# Constantes
const MAX_SPEED = 90
const AIR_SPEED = 72
const AIR_SPEED_2 = 90
const JUMP_H = 375
const JUMP_H_2 = 325
const gravity = 25

# Variables para debugging
export var auto_jump = false
export var see_controllable = false
export var teleport = false

# Referencias a otros nodos
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var playback = $AnimationTree.get("parameters/playback")
onready var collision = $CollisionShape2D
onready var ladder_detector = $ladder_detector

# Variables auxiliares
var awake = false
var controllable = true
var jumping = false
var was_on_floor = false
var on_ladder = false
var air_jump = false
var air_time = 0

var motion = Vector2()

func initialize(n):
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		add_collision_exception_with(player)
	var rot = -rad2deg(n.angle_to(Vector2(0,-1)))
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot
	
func modify_sprite(n, forward, backward):
	var left = n.rotated(deg2rad(90))
	var side_motion = left.dot(motion)
	var flip = false
	if n.x < 0 or n.y > 0:
		flip = true
	
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
			
func calc_motion(n, forward, backward, top, btm):
	
	var on_floor = is_on_floor()
	
	if jumping:
		if (air_time < AIR_SPEED):
			air_time += 1
	else:
		air_time = 0
		
	if motion.dot(n) > -JUMP_H:
		motion += -gravity * n
			
	if on_floor:
		jumping = false
		controllable = true
	
	# Movimiento horizontal
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	
	var vertical_vel = Input.get_action_strength(top) - Input.get_action_strength(btm)
	
	# Movimiento vertical (salto)
	
	if Input.is_action_just_pressed("ui_accept") and awake:
		
		air_time = 0
		
		# Caso segundo salto
		if not air_jump:
			air_jump = true
			motion = n * JUMP_H_2
			jumping = true
			controllable = true

		# Caso salto inicial
		if on_floor:
			motion = n * JUMP_H
			jumping = true
		
	if on_floor:
		air_jump = false
	
	# AUTO JUMP PARA DEBUGGING
	if was_on_floor and not on_floor and auto_jump:
		motion = n * JUMP_H
		jumping = true
	
	# Casos de incontrolabilidad
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso saltar al vacio
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
			if air_jump:
				motion.x = target_vel * (AIR_SPEED_2 - air_time)
			else:
				motion.x = target_vel * (AIR_SPEED - air_time)
		if not awake:
			motion.x = 0
	else:
		if on_floor:
			motion.y = target_vel * MAX_SPEED
		else:
			if air_jump:
				motion.y = target_vel * (AIR_SPEED_2 - air_time)
			else:
				motion.y = target_vel * (AIR_SPEED - air_time)
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
