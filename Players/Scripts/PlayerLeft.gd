extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(-1,0)
var cherry_controls = false
var id = 3
var wall = preload("res://InvisiWalls/InvisiWallLeft.tscn")

var w1 = "res://Sprites/GuySprites/LeftGuy/LeftAll.png"
var w2 = "res://Sprites/GuySprites/LeftGuy/LeftWorld2.png"
var w3 = "res://Sprites/GuySprites/LeftGuy/LeftHell.png"
var boots = "res://Sprites/GuySprites/LeftGuy/LeftBoots.png"
var textures = [w1, w2, w3, boots]

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
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
