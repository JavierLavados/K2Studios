extends Area2D

onready var sprite = $Sprite

var inside = false
var activated = false

var current

func lever(switch1, switch2, number, active_frame, sleeping_frame):
	current = get_parent().current

	if current == number and get_parent().lever_restriction[number] == 0:
		if (Input.is_action_just_pressed(switch1) or Input.is_action_just_pressed(switch2)) and inside:
			if activated:
				activated = false
				get_parent().lever = 4
			else:
				activated = true
				get_parent().lever = current
		
	if get_parent().lever == number:
		activated = true
	else:
		activated = false
		
	if activated:
		sprite.frame = active_frame
	else:
		sprite.frame = sleeping_frame
