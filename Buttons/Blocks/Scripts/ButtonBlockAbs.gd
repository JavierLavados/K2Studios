extends RigidBody2D

onready var world = get_node("/root/SceneSwitcher/newRoot/World")
onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func buttonBlock(id):
	if world.buttons[id] == 0:
		coll.disabled = true
		sprite.frame = (8*(Globals.current_world-1)) + (id*2+1)
	else:
		if world.button_restriction[id] == 0:
			coll.disabled = false
			sprite.frame = (8*(Globals.current_world-1)) + (id*2)
