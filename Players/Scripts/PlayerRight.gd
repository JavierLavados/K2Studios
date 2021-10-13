extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(1,0)
var cherry_controls = false
var id = 1
var wall = preload("res://InvisiWalls/InvisiWallRight.tscn")

var text1 = "res://Sprites/GuySprites/UpGuy/RightAll.png"
var text2 = "res://Sprites/GuySprites/UpGuy/RightBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "right", "left", "up", "down")
		modify_sprite(NORMAL, "right", "left")
	else:
		calc_motion(NORMAL, "down", "up", "right", "left")
		modify_sprite(NORMAL, "down", "up")
