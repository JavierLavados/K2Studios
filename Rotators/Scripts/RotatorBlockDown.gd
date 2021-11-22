extends "res://Rotators/Scripts/RotatorBlockAbs.gd"

var on = 26
var off = 34
var id = 2

func _physics_process(delta):
	rotatorBlock(id)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
		get_parent().collisions += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
		get_parent().collisions -= 1
