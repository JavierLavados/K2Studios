extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(-1,0)
var cherry_controls = false
var id = 3
var wall = preload("res://InvisiWalls/InvisiWallLeft.tscn")

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
		modify_sprite(NORMAL, "left", "right")
	else:
		calc_motion(NORMAL, "down", "up", "right", "left")
		modify_sprite(NORMAL, "down", "up")
