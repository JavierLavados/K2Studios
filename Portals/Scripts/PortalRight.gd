extends "res://Portals/Scripts/PortalAbstract.gd"

var id = 1
var rot = 90
var key1 = "left"
var key2 = "right"

func _ready():
	var t = "res://Sprites/Portals/PortalRightW" + str(Globals.current_world) + ".png"
	sprite.texture = load(t)
	sprite.rotation_degrees = rot

func _physics_process(delta):
	portal(id,key1,key2)

func _on_DoorRight_body_entered(body):
	if player:
		if body == player:
			inside = true

func _on_DoorRight_body_exited(body):
	inside = false
