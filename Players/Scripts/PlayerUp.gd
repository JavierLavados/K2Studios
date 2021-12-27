extends "res://Players/Scripts/PlayerAbstract.gd"

const NORMAL = Vector2(0, -1)
var cherry_controls = false
var wall = preload("res://InvisiWalls/InvisiWallUp.tscn")

var texture = "res://Sprites/GuySprites/UpGuy/Up"

func _ready():
	id = 0
	default_texture = texture + "W" + str(Globals.current_world) + ".png"
	boots_texture = texture + "Boots.png"
	initialize(NORMAL, wall)
	
func _physics_process(delta):
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
		if NORMAL != cloud.id:
			cloud.respawn_restriction -= 1
