extends Node2D

func _on_Ladder_body_entered(body):
	if body.is_in_group("Players"):
		body.on_ladder += 1
		body.detector_pos = [int(global_position.x),1]

func _on_Ladder_body_exited(body):
	if body.is_in_group("Players"):
		body.on_ladder -= 1
		body.detector_pos = null
