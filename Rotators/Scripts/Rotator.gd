extends Node2D

var moving = false
var restriction = [0,0,0,0]
var collisions = 0


func _process(delta):
	
	if get_parent().diff_lever:
		match get_parent().lever:
			0:
				rotation_degrees = 0
			1:
				rotation_degrees = 270
			2:
				rotation_degrees = 180
			3:
				rotation_degrees = 90
		get_parent().diff_lever = false
		
	if rotation_degrees >= 360:
		rotation_degrees = int(rotation_degrees)%360
		
	match get_parent().lever:
		0:
			if int(rotation_degrees)%360 > 0:
				rotation_degrees = ceil(rotation_degrees+1)
				moving = true
			else:
				rotation_degrees = 0
				moving = false
		1:
			if int(rotation_degrees)%360 != 270:
				rotation_degrees = ceil(rotation_degrees+1)
				moving = true
			else:
				rotation_degrees = 270
				moving = false
		2:
			if int(rotation_degrees)%360 != 180:
				rotation_degrees = ceil(rotation_degrees+1)
				moving = true
			else:
				rotation_degrees = 180
				moving = false
		3:
			if int(rotation_degrees)%360 != 90:
				rotation_degrees = ceil(rotation_degrees+1)
				moving = true
			else:
				rotation_degrees = 90
				moving = false
	
	if moving or collisions > 0:
		restriction = [1,1,1,1]
	else:
		restriction = [0,0,0,0]
	
	get_parent().lever_restriction = restriction
