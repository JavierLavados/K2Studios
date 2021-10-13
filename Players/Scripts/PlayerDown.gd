extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, 1)
var cherry_controls = false
var id = 2
var wall = preload("res://InvisiWalls/InvisiWallDown.tscn")

var text1 = "res://Sprites/GuySprites/UpGuy/DownAll.png"
var text2 = "res://Sprites/GuySprites/UpGuy/DownBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
		modify_sprite(NORMAL, "left", "right")
	else:
		calc_motion(NORMAL, "right", "left", "up", "down")
		modify_sprite(NORMAL, "right", "left")
