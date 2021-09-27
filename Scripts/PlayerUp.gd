extends KinematicBody2D

const ACCELERATION = 200 # NO SE ESTA USANDO!
const MAX_SPEED = 200
const JUMP_H = 1100
const UP = Vector2(0, -1)
const gravity = 120
const forward = "right" #right/down
const backward = "left" #left/up

var jumps = 0

# Variables para debugging
export var auto_jump = false
export var see_controllable = false
export var teleport = true

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var scl = sprite.scale.x
onready var playback = $AnimationTree.get("parameters/playback")
onready var collision = $CollisionShape2D
onready var ladder_detector = $ladder_detector

var motion = Vector2()

var awake = false
var controllable = true
var jumping = false
var was_on_floor = false
var left = UP.rotated(deg2rad(90))
var on_ladder = false

func _ready():
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		add_collision_exception_with(player)
	var rot = -rad2deg(UP.angle_to(Vector2(0,-1)))
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot
	
func is_on_ladder():
	var areas = ladder_detector.get_overlapping_areas()
	if areas.size() > 0:
		for area in areas:
			if "ladder".to_upper() in area.name.to_upper():
				on_ladder = area.get_parent().position
	else:
		on_ladder = false
	return on_ladder
	
func check_block_collision(hspd, collisions):
	for i in collisions:
		var block : = get_slide_collision(i).collider as Block
		if block:
			block.push(hspd)

func _physics_process(delta):
	
	var on_floor = is_on_floor()

	motion += -(gravity/scl) * UP
		
	if on_floor:
		jumps = 0
		jumping = false
		controllable = true
	
	# Movimiento horizontal
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	
	var vertical_vel = Input.get_action_strength("up") - Input.get_action_strength("down")
	
	# Movimiento vertical (salto)
	#if on_floor:
	if Input.is_action_just_pressed("ui_accept") && jumps < 2:
		motion = UP * JUMP_H/scl
		jumps += 1
		jumping = true
		
	
	if was_on_floor and not on_floor and auto_jump:
		motion = UP * JUMP_H/scl
		jumping = true
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso saltar al vacio
	if motion.dot(UP) < -(JUMP_H/scl)+30 and jumping:
		controllable = false
	
	# Incontrolable al despertar
	if ((playback.get_current_node() == "Sleep") or (playback.get_current_node() == "WakeUp")):
		controllable = false
		
	if not controllable:
		if see_controllable:
			$Sprite.modulate = Color.blue
		target_vel = 0
	else:
		if see_controllable:
			$Sprite.modulate = Color.white
	
	if UP.x == 0:
		# Es necesario expresar el movimiento asi?
		#motion.x = Vector2(motion.x, 0).move_toward(Vector2(target_vel * MAX_SPEED/scl, 0), ACCELERATION/scl).x
		motion.x = target_vel * MAX_SPEED/scl
	else:
		motion.y = Vector2(0, motion.y).move_toward(Vector2(0, target_vel * MAX_SPEED/scl), ACCELERATION/scl).y
		
	# Interaccion con escaleras
	is_on_ladder()
	if on_ladder and Input.is_action_pressed("up"):
		if position.x != on_ladder.x:
			position = on_ladder
	
	# Empujar cajas:
	var count = get_slide_count()
	if count > 1:
		check_block_collision(motion.x, count)
	
	if awake:
		motion = move_and_slide(motion, UP)
	else:
		motion = Vector2.ZERO
		
	# Sprite
	var side_motion = left.dot(motion)
	
	if awake:
		if Input.is_action_just_pressed(forward):
			sprite.flip_h = false
			ladder_detector.scale.x = 1
		if Input.is_action_just_pressed(backward):
			sprite.flip_h = true
			ladder_detector.scale.x = -1
			
	if not awake:
		playback.travel("Sleeping")
	else:
		if side_motion != 0:
			playback.travel("Walk")
		else:
			playback.travel("Idle")
		
	# Debugging	
	if Input.is_action_just_pressed("teleport") and teleport:
		global_position = get_global_mouse_position()
	
	
	
	
	
	
