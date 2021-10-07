extends "res://InvisiWalls/Scripts/InvisiWallAbs.gd"

func _ready():
	setUp(2)

func _process(delta):
	if not exists:
		queue_free()
