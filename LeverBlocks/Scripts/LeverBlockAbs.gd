extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D

var lever

func leverBlock(number, solid, transparent):
	lever = get_parent().lever
	if lever == number:
		sprite.frame = solid
		coll.disabled = false
	else:
		sprite.frame = transparent
		coll.disabled = true
