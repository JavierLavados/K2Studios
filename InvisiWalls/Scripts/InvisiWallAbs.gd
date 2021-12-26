extends StaticBody2D

var exists = true

onready var world = get_node("/root/World")

func setUp(id):
	var players = world.players
	var ids = world.ids
	for i in range(len(players)):
		if ids[i] != id:
			add_collision_exception_with(players[i])
	var blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		add_collision_exception_with(block)
