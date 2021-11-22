extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func rotatorBlock(id):
	if get_parent().moving == true:
		coll.disabled = true
		sprite.frame = (8*(Globals.current_world-1)) + (id*2+1)
	else:
		coll.disabled = false
		sprite.frame = (8*(Globals.current_world-1)) + (id*2)
		sprite.rotation_degrees = -get_parent().rotation_degrees
