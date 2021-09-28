extends "res://LeverBlocks/Scripts/LeverBlockAbs.gd"

var id = 2

func _physics_process(delta):
	leverBlock(id, 26, 34)

func _on_Area2D_body_entered(body):
	if body in players:
		get_parent().lever_restriction[id] += 1

func _on_Area2D_body_exited(body):
	if body in players:
		get_parent().lever_restriction[id] -= 1
