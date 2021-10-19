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
		
	if rotation_degrees < 0:
		rotation_degrees += 360
		
	if rotation_degrees >= 360:
		rotation_degrees = int(rotation_degrees)%360
		
			
	var mov = delta * 120
		
	match get_parent().lever:
		0:	
			if rotation_degrees > 358 or (rotation_degrees > -2 and rotation_degrees < 2):
				if moving:
					rotation_degrees = 0
					moving = false
			else:
				moving = true
			if moving:
				if int(rotation_degrees)%360 <= 90:
					rotation_degrees -= mov
				else:
					rotation_degrees += mov
		1:
			if rotation_degrees > 268 and rotation_degrees < 272 :
				if moving:
					moving = false
					rotation_degrees = 270
			else:
				moving = true
			if moving:
				if int(rotation_degrees)%360 > 270 or int(rotation_degrees)%360 < 45:
					rotation_degrees -= mov
				else:
					rotation_degrees += mov
			
		2:
			if rotation_degrees > 178 and rotation_degrees < 182 :
				if moving:
					moving = false
					rotation_degrees = 180
			else:
				moving = true
			if moving:
				if int(rotation_degrees)%360 <= 270 and int(rotation_degrees)%360 > 180:
					rotation_degrees -= mov
				else:
					rotation_degrees += mov

		3:
			if rotation_degrees > 88 and rotation_degrees < 92 :
				if moving:
					moving = false
					rotation_degrees = 90
			else:
				moving = true
			if moving:
				if int(rotation_degrees)%360 <= 180 and int(rotation_degrees)%360 > 90:
					rotation_degrees -= mov
				else:
					rotation_degrees += mov
						
	if moving or collisions > 0:
		restriction = [1,1,1,1]
	else:
		restriction = [0,0,0,0]
	
	get_parent().lever_restriction = restriction
