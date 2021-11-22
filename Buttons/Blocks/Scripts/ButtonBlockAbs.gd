extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func buttonBlock(id):
	if get_tree().root.get_child(1).buttons[id] == 0:
		coll.disabled = true
		sprite.frame = (8*(Globals.current_world-1)) + (id*2+1)
	else:
		coll.disabled = false
		sprite.frame = (8*(Globals.current_world-1)) + (id*2)
