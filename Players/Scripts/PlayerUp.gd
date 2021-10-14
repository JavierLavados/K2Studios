extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, -1)
var cherry_controls = false
var id = 0
var wall = preload("res://InvisiWalls/InvisiWallUp.tscn")

var w1 = "res://Sprites/GuySprites/UpGuy/UpAll.png"
var w2 = "res://Sprites/GuySprites/UpGuy/UpWorld2.png"
var w3 = "res://Sprites/GuySprites/UpGuy/UpHell.png"
var boots = "res://Sprites/GuySprites/UpGuy/UpBoots.png"
var textures = [w1, w2, w3, boots]

func _ready():
	initialize(NORMAL, wall)
	
func _physics_process(delta):
	calc_motion(NORMAL, "right", "left", "up", "down")

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
