extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, 1)
var cherry_controls = false
var id = 2
var wall = preload("res://InvisiWalls/InvisiWallDown.tscn")

var w1 = "res://Sprites/GuySprites/DownGuy/DownAll.png"
var w2 = "res://Sprites/GuySprites/DownGuy/DownWorld2.png"
var w3 = "res://Sprites/GuySprites/DownGuy/DownHell.png"
var boots = "res://Sprites/GuySprites/DownGuy/DownBoots.png"
var textures = [w1, w2, w3, boots]

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):

	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
	else:
		calc_motion(NORMAL, "right", "left", "up", "down")

func _on_Area2D_area_entered(area):
	if area.name == "CloudArea":
		var cloud = area.get_parent()
		if NORMAL != cloud.id:
			cloud.disabled = true
		cloud.respawn_restriction += 1

func _on_Area2D_area_exited(area):
	if area.name == "CloudArea":
		var cloud = area.get_parent()
		cloud.respawn_restriction -= 1
