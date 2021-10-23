extends KinematicBody2D

const MAX_SPEED = 240

onready var sprite = $Sprite

var motion = Vector2(0,0)
var on_node = false
var node_pos = null
var positions = []
var gap = 10
var order = [0,1,2,3]
var waiting = false
var directions = null
var dir = null

var go_back = false
var current_node = null

func _physics_process(delta):

	if current_node:
		on_node = true
		node_pos = current_node.global_position
		directions = current_node.directions
		current_node = null
	
	if len(positions) == (gap*3)+1:
		if positions[0] == positions[gap*3] and positions[gap] == positions[0]:
			waiting = false

	var h_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	var v_vel = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	
	if (h_vel != 0 or v_vel != 0) and on_node and not waiting:
		
		if h_vel != 0:
			if h_vel == 1 and directions[1]:
				dir = 1
				order = [0,1,2,3]
				on_node = false
				motion = Vector2(h_vel * MAX_SPEED,0)
				for i in range(4):
					get_child(i).order = order[i]
					get_child(i).on_node = false
			if h_vel == -1 and directions[3]:
				dir = 3
				order = [3,2,1,0]
				on_node = false
				motion = Vector2(h_vel * MAX_SPEED,0)
				for i in range(4):
					get_child(i).order = order[i]
					get_child(i).on_node = false
		if v_vel != 0:
			if v_vel == 1 and directions[2]:
				dir = 2
				order = [2,0,3,1]
				on_node = false
				motion = Vector2(0,v_vel * MAX_SPEED)
				for i in range(4):
					get_child(i).order = order[i]
					get_child(i).on_node = false
			if v_vel == -1 and directions[0]:
				dir = 0
				order = [1,3,0,2]
				on_node = false
				motion = Vector2(0,v_vel * MAX_SPEED)
				for i in range(4):
					get_child(i).order = order[i]
					get_child(i).on_node = false
		
		waiting = true
		
	if go_back:
		motion.x = -motion.x
		motion.y = -motion.y
		go_back = false
		
	move_and_slide(motion)

	if on_node:
		global_position = node_pos
		if not waiting:
			dir = null
		
	if len(positions) > gap*3:
		positions.pop_front()
	positions.append(global_position)
