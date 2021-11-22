extends StaticBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite
var id = 3

func _ready():
	sprite.frame = (8*(Globals.current_world-1)) + (id*2)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
		coll.shape.extents.x = 8
		coll.position.x = 8
		sprite.frame = (8*(Globals.current_world-1)) + (id*2+1)
		get_parent().buttons[3] += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
		coll.shape.extents.x = 15
		coll.position.x = 1
		sprite.frame = (8*(Globals.current_world-1)) + (id*2)
		get_parent().buttons[3] -= 1
