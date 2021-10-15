extends Node2D

onready var sprite = $Sprite

var id = 0

func _on_Ladder_body_entered(body):
	if body.name == "PlayerUp":
		body.on_ladder += 1
		body.detector_pos = [int(global_position.x),1]

func _on_Ladder_body_exited(body):
	if body.name == "PlayerUp":
		body.on_ladder -= 1
		body.detector_pos = null

func _on_AreaZ_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerUp":
		body.sprite.z_index -= 3

func _on_AreaZ_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerUp":
		body.sprite.z_index += 3
