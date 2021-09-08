extends KinematicBody2D

const ACCELERATION = 30
const MAX_SPEED = 50
const JUMP_H = -220
const UP = Vector2(0, -1)
const gravity = 20

# Variables para debugging
export var auto_jump = false
export var see_controllable = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

var controllable = true
var jumping = false

var jump_x = 0
var jump_travel = 0
var max_jump_travel = 10

var was_on_floor = false

func _physics_process(delta):
	
	var on_floor = is_on_floor()

	motion.y += gravity
	var friction = false
		
	if on_floor:
		jumping = false
		controllable = true
	
	# Movimiento horizontal
	var target_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	# Movimiento vertical
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
			jumping = true
	
	if was_on_floor and not on_floor and auto_jump:
		motion.y = JUMP_H
		jumping = true
	
	# Caso lanzarse sin saltar
	if was_on_floor and not on_floor and not jumping:
		controllable = false
	was_on_floor = on_floor
	
	# Caso saltar al vacio
	if motion.y > -JUMP_H-30 and jumping:
		controllable = false
		
	if not controllable:
		if see_controllable:
			$Sprite.modulate = Color.blue
		target_vel = 0
	else:
		if see_controllable:
			$Sprite.modulate = Color.white
	
	motion.x = Vector2(motion.x, 0).move_toward(Vector2(target_vel * MAX_SPEED, 0), ACCELERATION).x
	motion = move_and_slide(motion, UP)
	
	# Sprite
	if motion.x > 0:
		sprite.flip_h = false
	if motion.x < 0:
		sprite.flip_h = true
	
	if motion.x != 0:
		animationPlayer.play("Walk")
	else:
		animationPlayer.play("Idle")
		
	# Debugging	
	if Input.is_action_just_pressed("teleport"):
		global_position = get_global_mouse_position()
		
	print(jumping)
			

	
	
	
	
	
	
