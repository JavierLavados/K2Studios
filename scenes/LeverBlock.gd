extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D

var lever

func _physics_process(delta):
	lever = get_parent().lever
	if lever == 0:
		sprite.frame = 24
		coll.disabled = false
	else:
		sprite.frame = 32
		coll.disabled = true
