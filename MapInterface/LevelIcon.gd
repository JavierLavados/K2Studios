extends Node2D

func _on_Area2D_body_entered(body):
	body.on_node = true
	if body.name == "MapPointer":
		body.node_pos = global_position

func _on_Area2D_area_entered(area):
	area.get_parent().on_node = true
