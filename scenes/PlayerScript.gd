extends KinematicBody2D

const ACCELERATION = 30
const MAX_SPEED = 50
const JUMP_H = 220
const UP = Vector2(0, 1)
const gravity = 20
const forward = "right" #down
const backward = "left" #up 

# Variables para debugging
export var auto_jump = false
export var see_controllable = true

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

var controllable = true
var jumping = false
var was_on_floor = false
var left = UP.rotated(deg2rad(90))

func _physics_process(delta):
	
	var on_floor = is_on_floor()

	motion += -gravity * UP
		
	if on_floor:
		jumping = false
		controllable = true
	
	# Movimiento horizontal
	var target_vel = Input.get_action_strength(forward) - Input.get_action_strength(backward)
	
	# Movimiento vertical
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"):
			motion = UP * JUMP_H
			jumping = true
	
	if was_on_floor and not on_floor and auto_jump:
		motion = UP * JUMP_H
		jumping = true
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso saltar al vacio
	if motion.dot(UP) < -JUMP_H+30 and jumping:
		controllable = false
		
	if not controllable:
		if see_controllable:
			$Sprite.modulate = Color.blue
		target_vel = 0
	else:
		if see_controllable:
			$Sprite.modulate = Color.white
	
	if UP.x == 0:
		motion.x = Vector2(motion.x, 0).move_toward(Vector2(target_vel * MAX_SPEED, 0), ACCELERATION).x
	else:
		motion.y = Vector2(0, motion.y).move_toward(Vector2(0, target_vel * MAX_SPEED), ACCELERATION).y
	motion = move_and_slide(motion, UP)
	
	# Sprite
	var side_motion = left.dot(motion)
	
	sprite.rotation_degrees = -rad2deg(UP.angle_to(Vector2(0,-1)))
	print(sprite.rotation_degrees)
	
	if side_motion > 0:
		sprite.flip_h = false
	if side_motion < 0:
		sprite.flip_h = true
	
	if side_motion != 0:
		animationPlayer.play("Walk")
	else:
		animationPlayer.play("Idle")
		
	# Debugging	
	if Input.is_action_just_pressed("teleport"):
		global_position = get_global_mouse_position()
	
	
	
	
	
	
