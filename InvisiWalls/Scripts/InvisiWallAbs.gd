extends StaticBody2D

var exists = true

func setUp(id):
	var players = get_tree().root.get_child(1).players
	var ids = get_tree().root.get_child(1).ids
	for i in range(len(players)):
		if ids[i] != id:
			add_collision_exception_with(players[i])
	var blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		add_collision_exception_with(block)
