extends "res://Levers/LeverBlocks/Scripts/LeverBlockAbs.gd"

var id = 3

func _physics_process(delta):
	leverBlock(3)

func _on_Area2D_body_entered(body):
	if body in players:
		world.lever_restriction[id] += 1

func _on_Area2D_body_exited(body):
	if body in players:
		world.lever_restriction[id] -= 1
