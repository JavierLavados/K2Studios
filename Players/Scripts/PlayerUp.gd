extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, -1)
var cherry_controls = false
var id = 0
var wall = preload("res://InvisiWalls/InvisiWallUp.tscn")

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):
	calc_motion(NORMAL, "right", "left", "up", "down")
	modify_sprite(NORMAL, "right", "left")
