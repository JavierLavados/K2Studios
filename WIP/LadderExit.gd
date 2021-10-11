extends StaticBody2D

onready var coll = $CollisionShape2D
onready var area2 = $Area2D2

var player_inside = false

func _process(delta):
	if player_inside:
		for body in area2.get_overlapping_bodies():
			if body.name == "PlayerUp":
				if body.climbing:
					coll.set_deferred("disabled",true)
				else:
					coll.set_deferred("disabled",false)
	
func _on_Area2D_body_entered(body):
	if body.name == "PlayerUp":
		body.on_ladder += 1
		body.ladder_pos = [int(global_position.x),true]
		coll.set_deferred("disabled",true)

func _on_Area2D_body_exited(body):
	if body.name == "PlayerUp":
		body.on_ladder -= 1
		coll.set_deferred("disabled",false)
		
func _on_Area2D2_body_entered(body):
	if body.name == "PlayerUp":
		body.ladder_pos = [int(global_position.x),false]
		player_inside = true
		body.on_detector = true

func _on_Area2D2_body_exited(body):
	if body.name == "PlayerUp":
		player_inside = false
		body.on_detector = false
