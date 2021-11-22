extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(1,0)
var cherry_controls = false
var id = 1
var wall = preload("res://InvisiWalls/InvisiWallRight.tscn")

var texture = "res://Sprites/GuySprites/RightGuy/Right"

func _ready():
	default_texture = texture + "W" + str(Globals.current_world) + ".png"
	boots_texture = texture + "Boots.png"
	initialize(NORMAL, wall)
	
func _physics_process(delta):

	if cherry_controls:
		calc_motion(NORMAL, "right", "left", "up", "down")
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
