extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(-1,0)
var cherry_controls = false
var wall = preload("res://InvisiWalls/InvisiWallLeft.tscn")

var texture = "res://Sprites/GuySprites/LeftGuy/Left"

func _ready():
	id = 3
	default_texture = texture + "W" + str(Globals.current_world) + ".png"
	boots_texture = texture + "Boots.png"
	initialize(NORMAL, wall)

func _physics_process(delta):
	if cherry_controls:
		calc_motion(NORMAL, "left", "right", "down", "up")
	else:
		calc_motion(NORMAL, "down", "up", "left", "right")

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
