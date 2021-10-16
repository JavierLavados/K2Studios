extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func buttonBlock(id, on_spr):
	if get_tree().root.get_child(1).buttons[id] == 0:
		coll.disabled = true
		sprite.frame = on_spr+8
	else:
		coll.disabled = false
		sprite.frame = on_spr
