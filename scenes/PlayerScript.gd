extends KinematicBody2D

const ACCELERATION = 30
const MAX_SPEED = 50
const JUMP_H = -200
const UP = Vector2(0, -1)
const gravity = 20

export var auto_jump = true

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

var jump_x = 0
var jump_travel = 0
var max_jump_travel = 10

var was_on_floor = false

func _physics_process(delta):
	
	motion = move_and_slide(motion, UP)
	var on_floor = is_on_floor()
	
	# apply gravity to the player
	motion.y += gravity
	var friction = false
	
	var target_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
#	if not on_floor:
#		target_vel = lerp(target_vel, 0, jump_travel / max_jump_travel)
	if abs(motion.y) > 200:
		target_vel = 0
		$Sprite.modulate = Color.blue
	else:
		$Sprite.modulate = Color.white
	
	motion.x = Vector2(motion.x, 0).move_toward(Vector2(target_vel * MAX_SPEED, 0), ACCELERATION).x
	
	if motion.x > 0:
		sprite.flip_h = true
	if motion.x < 0:
		sprite.flip_h = false
	

	if motion.x != 0:
		animationPlayer.play("Walk")
	else:
		animationPlayer.play("Idle")
		friction = true
	
	if auto_jump and was_on_floor and not on_floor:
		motion.y = JUMP_H
		jump_x = global_position.x
	was_on_floor = on_floor
		
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
			jump_x = global_position.x
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		jump_travel = clamp((global_position.x - jump_x), -max_jump_travel, max_jump_travel)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
			
	print(motion.length())
	
	if Input.is_action_just_pressed("teleport"):
		global_position = get_global_mouse_position()
			

	
	
	
	
	
	
	
