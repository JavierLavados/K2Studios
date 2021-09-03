extends KinematicBody2D

const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_H = -650
const UP = Vector2(0, -1)
const gravity = 100

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()
var controllable = true
var jumping = false

func _physics_process(delta):
	motion.y += gravity
	var friction = false
	print(motion.y)
	
	if controllable:
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = false
			animationPlayer.play("Walk")
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		elif Input.is_action_pressed("ui_left"):
			sprite.flip_h = true
			animationPlayer.play("Walk")
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		else:
			animationPlayer.play("Idle")
			friction = true
	else:
		motion.x = 0
	
	if is_on_floor():
		controllable = true
		jumping = false
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
			jumping = true
		if friction:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if controllable:
			if (not jumping):
				controllable = false
		if friction:
			motion.x = lerp(motion.x, 0, 0.1)
	
	motion = move_and_slide(motion, UP)
				
