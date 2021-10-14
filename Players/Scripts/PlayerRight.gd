extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(1,0)
var cherry_controls = false
var id = 1
var wall = preload("res://InvisiWalls/InvisiWallRight.tscn")

var text1 = "res://Sprites/GuySprites/RightGuy/RightAll.png"
var text2 = "res://Sprites/GuySprites/RightGuy/RightBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "right", "left", "up", "down")
	else:
		calc_motion(NORMAL, "down", "up", "right", "left")
