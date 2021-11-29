extends StaticBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite
var id = 2

func _ready():
	sprite.frame = (8*(Globals.current_world-1)) + (id*2)

func _on_Area2D_body_entered(body):
	if body.name == "PlayerDown":
		coll.shape.extents.y = 8
		coll.position.y = -8
		sprite.frame = (8*(Globals.current_world-1)) + (id*2+1)
		get_parent().buttons[2] += 1

func _on_Area2D_body_exited(body):
	if body.name == "PlayerDown":
		coll.shape.extents.y = 15
		coll.position.y = -1
		sprite.frame = (8*(Globals.current_world-1)) + (id*2)
		get_parent().buttons[2] -= 1
