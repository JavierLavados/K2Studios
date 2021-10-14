extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, -1)
var cherry_controls = false
var id = 0
var wall = preload("res://InvisiWalls/InvisiWallUp.tscn")

var text1 = "res://Sprites/GuySprites/UpGuy/UpAll.png"
var text2 = "res://Sprites/GuySprites/UpGuy/UpBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
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
