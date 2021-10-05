extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func rotatorBlock(on_spr, off_spr):
	if get_parent().moving == true:
		coll.disabled = true
		sprite.frame = off_spr
	else:
		coll.disabled = false
		sprite.frame = on_spr
		sprite.rotation_degrees = -get_parent().rotation_degrees
