extends KinematicBody2D

const MAX_SPEED = 160

onready var sprite = $Sprite

var motion = Vector2(0,0)
var on_node = true
var center = false
var node_pos = null
var gap = 10
var positions = []

func modify_sprite(motion, on_node):
	if on_node:
		sprite.frame = 0
	else:
		if motion.x != 0:
			sprite.frame = 10
			if motion.x > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		else:
			if motion.y != 0:
				if motion.	y > 0:
					sprite.frame = 12
				else:
					sprite.frame = 11

func _physics_process(delta):

	var h_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	var v_vel = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if (h_vel != 0 or v_vel != 0) and on_node and not center:
		on_node = false
		motion.x = h_vel * MAX_SPEED
		motion.y = v_vel * MAX_SPEED

	if on_node:
		if center:
			var h_dir = node_pos.x - global_position.x
			var v_dir = node_pos.y - global_position.y
			motion = Vector2(sign(h_dir)*128,sign(v_dir)*128)
		else:
			motion = Vector2(0,0)
	
	modify_sprite(motion, on_node)
	
	if center:
		if global_position.distance_to(node_pos) <= 2:
			center = false
			global_position = node_pos

	if len(positions) > gap:
		positions.pop_front()
	positions.append(global_position)
		
	move_and_slide(motion)
