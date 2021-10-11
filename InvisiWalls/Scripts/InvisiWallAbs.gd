extends StaticBody2D

var exists = true

func setUp(id):
	var playerUp = get_tree().root.get_child(0).get_node("PlayerUp")
	var playerRight = get_tree().root.get_child(0).get_node("PlayerRight")
	var playerDown = get_tree().root.get_child(0).get_node("PlayerDown")
	var playerLeft = get_tree().root.get_child(0).get_node("PlayerLeft")
	var players = [playerUp, playerRight, playerDown, playerLeft]
	for i in range(4):
		if i != id:
			add_collision_exception_with(players[i])
	var blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		add_collision_exception_with(block)
