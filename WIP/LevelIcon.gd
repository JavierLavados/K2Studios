extends Node2D

func _on_Area2D_body_entered(body):
	body.on_node = true
	body.center = true
	body.node_pos = global_position
