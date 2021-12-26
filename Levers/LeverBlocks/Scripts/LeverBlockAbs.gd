extends StaticBody2D


onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var players = get_tree().get_nodes_in_group("Players")
onready var world = get_node("/root/SceneSwitcher/newRoot/World")

var lever

func leverBlock(number):
	
	lever = world.lever
		
	if lever == number:
		sprite.frame = (8*(Globals.current_world-1)) + (number*2)
		coll.disabled = false
	else:
		sprite.frame = (8*(Globals.current_world-1)) + (number*2+1)
		coll.disabled = true
