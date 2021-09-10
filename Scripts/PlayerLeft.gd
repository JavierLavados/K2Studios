extends KinematicBody2D

const ACCELERATION = 140
const MAX_SPEED = 200
const JUMP_H = 1100
const UP = Vector2(-1, 0)
const gravity = 120
const forward = "down" #right/down
const backward = "up" #left/up 

# Variables para debugging
export var auto_jump = false
export var see_controllable = false
export var teleport = true

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var scl = sprite.scale.x
onready var playback = $AnimationTree.get("parameters/playback")
onready var collision = $CollisionShape2D

var motion = Vector2()

var awake = false
var controllable = true
var jumping = false
var was_on_floor = false
var left = UP.rotated(deg2rad(90))

func _ready():
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		add_collision_exception_with(player)
	var rot = -rad2deg(UP.angle_to(Vector2(0,-1)))
	sprite.rotation_degrees = rot
	collision.rotation_degrees = rot

func _physics_process(delta):
	
	var on_floor = is_on_floor()

	motion += -(gravity/scl) * UP
		
	if on_floor:
		jumping = false
		controllable = true
	
	# Movimiento horizontal
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	
	# Movimiento vertical
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"):
			motion = UP * JUMP_H/scl
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
		motion.x = Vector2(motion.x, 0).move_toward(Vector2(target_vel * MAX_SPEED/scl, 0), ACCELERATION/scl).x
	else:
		motion.y = Vector2(0, motion.y).move_toward(Vector2(0, target_vel * MAX_SPEED/scl), ACCELERATION/scl).y
	
	if awake:
		motion = move_and_slide(motion, UP)
	else:
		motion = Vector2.ZERO
	
	# Sprite
	var side_motion = left.dot(motion)
	
	if awake:
		if Input.is_action_just_pressed(forward):
			sprite.flip_h = true
		if Input.is_action_just_pressed(backward):
			sprite.flip_h = false
	
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
	
	
	
	
	
	
