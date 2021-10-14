extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, 1)
var cherry_controls = false
var id = 2
var wall = preload("res://InvisiWalls/InvisiWallDown.tscn")

var text1 = "res://Sprites/GuySprites/DownGuy/DownAll.png"
var text2 = "res://Sprites/GuySprites/DownGuy/DownBoots.png"

func _ready():
	initialize(NORMAL, wall, text1, text2)
	
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
			cloud.respawn = false

func _on_Area2D_area_exited(area):
	if area.name == "CloudArea":
		var cloud = area.get_parent()
		if NORMAL != cloud.id:
			cloud.respawn = true
