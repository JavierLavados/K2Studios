extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(1,0)
var cherry_controls = false
var id = 1
var wall = preload("res://InvisiWalls/InvisiWallRight.tscn")

var w1 = "res://Sprites/GuySprites/RightGuy/RightAll.png"
var w2 = "res://Sprites/GuySprites/RightGuy/RightWorld2.png"
var w3 = "res://Sprites/GuySprites/RightGuy/RightHell.png"
var boots = "res://Sprites/GuySprites/RightGuy/RightBoots.png"
var textures = [w1, w2, w3, boots]

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "right", "left", "up", "down")
	else:
		calc_motion(NORMAL, "down", "up", "right", "left")

func _on_Area2D_area_entered(area):
	if area.name == "CloudArea":
		var cloud = area.get_parent()
		if NORMAL != cloud.id:
			cloud.disabled = true
			cloud.respawn = false

func _on_Area2D_area_exited(area):
	if area.name == "CloudArea":
		var cloud = area.get_parent()
		if NORMAL != cloud.id:
			cloud.respawn = true
