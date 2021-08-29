extends KinematicBody2D

const ACCELERATION = 80
const MAX_SPEED = 250
const JUMP_H = -800
const UP = Vector2(0, -1)
const gravity = 60

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

func _physics_process(delta):
	# apply gravity to the player
	motion.y += gravity
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = true
		animationPlayer.play("Walk")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	
	else:
		animationPlayer.play("Idle")
		friction = true
		
		
	if is_on_floor():
		
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
	
	motion = move_and_slide(motion, UP)
			
	
	
	
	
	
	
	
	
	
	
