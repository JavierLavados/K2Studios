extends "res://Buttons/Blocks/Scripts/ButtonBlockAbs.gd"


var on_spr = 24
var id = 0

func _process(delta):
	buttonBlock(id)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
			world.button_restriction[id] += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
			world.button_restriction[id] -= 1

func _on_PushBlockArea_body_entered(body):
	if body.is_in_group("Blocks"):
		world.button_restriction[id] += 1

func _on_PushBlockArea_body_exited(body):
	if body.is_in_group("Blocks"):
		world.button_restriction[id] -= 1
