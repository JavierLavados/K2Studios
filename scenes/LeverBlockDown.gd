extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D

var lever

func _physics_process(delta):
	lever = get_parent().lever
	if lever == 2:
		sprite.frame = 26
		coll.disabled = false
	else:
		sprite.frame = 34
		coll.disabled = true
