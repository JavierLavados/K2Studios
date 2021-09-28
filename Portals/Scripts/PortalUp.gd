extends "res://Portals/Scripts/PortalAbstract.gd"

var id = 0
var rot = 0
var key1 = "up"
var key2 = "down"

func _ready():
	sprite.rotation_degrees = rot

func _physics_process(delta):
	portal(id,key1,key2)

func _on_DoorUp_body_entered(body):
	if player:
		if body == player:
			inside = true

func _on_DoorUp_body_exited(body):
	inside = false
