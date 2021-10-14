extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(-1,0)
var cherry_controls = false
var id = 3
var wall = preload("res://InvisiWalls/InvisiWallLeft.tscn")

var text1 = "res://Sprites/GuySprites/LeftGuy/LeftAll.png"
var text2 = "res://Sprites/GuySprites/LeftGuy/LeftBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
	else:
		calc_motion(NORMAL, "down", "up", "right", "left")
