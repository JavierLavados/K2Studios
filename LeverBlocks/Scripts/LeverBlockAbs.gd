extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var players = get_tree().get_nodes_in_group("Players")

var lever

func leverBlock(number, solid, transparent):
	
	lever = get_tree().root.get_child(1).lever
		
	if lever == number:
		sprite.frame = solid
		coll.disabled = false
	else:
		sprite.frame = transparent
		coll.disabled = true
