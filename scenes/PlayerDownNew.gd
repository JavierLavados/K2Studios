extends "res://scenes/PlayerAbstract.gd"

const NORMAL = Vector2(0, 1)
var cherry_controls = false

func _ready():
	initialize(NORMAL)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
		modify_sprite(NORMAL, "left", "right")
	else:
		calc_motion(NORMAL, "right", "left", "up", "down")
		modify_sprite(NORMAL, "right", "left")
