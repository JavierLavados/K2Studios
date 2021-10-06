extends StaticBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
		coll.shape.extents.x = 8
		coll.position.x = -8
		sprite.frame = 3
		get_parent().buttons[1] += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
		coll.shape.extents.x = 15
		coll.position.x = -1
		sprite.frame = 2
		get_parent().buttons[1] -= 1
