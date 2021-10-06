extends StaticBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
		coll.shape.extents.y = 8
		coll.position.y = -8
		sprite.frame = 5
		get_parent().buttons[2] += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
		coll.shape.extents.y = 15
		coll.position.y = -1
		sprite.frame = 4
		get_parent().buttons[2] -= 1
