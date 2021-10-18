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

func _physics_process(delta):
	
	print(waiting)
	
	if len(positions) == (gap*3)+1:
		if positions[0] == positions[gap*3]:
				waiting = false

	var h_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	var v_vel = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if (h_vel != 0 or v_vel != 0) and on_node and not waiting:
		on_node = false
		motion.x = h_vel * MAX_SPEED
		motion.y = v_vel * MAX_SPEED
		if h_vel != 0:
			if h_vel == 1:
				order = [0,1,2,3]
			else:
				order = [3,2,1,0]
		if v_vel != 0:
			if v_vel == 1:
				order = [2,0,3,1]
			else:
				order = [1,3,0,2]
		
		for i in range(4):
			get_child(i).order = order[i]
			get_child(i).on_node = false
		
		waiting = true
	
	move_and_slide(motion)
	
	if on_node:
		global_position = node_pos
		
	if len(positions) > gap*3:
		positions.pop_front()
	positions.append(global_position)
