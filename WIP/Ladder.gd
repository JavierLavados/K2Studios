extends Node2D

func _on_Ladder_body_entered(body):
	if body.is_in_group("Players"):
		body.on_ladder += 1
		body.on_detector = true
		body.ladder_pos = [int(global_position.x),true]

func _on_Ladder_body_exited(body):
	if body.is_in_group("Players"):
		body.on_ladder -= 1
		body.on_detector = false
