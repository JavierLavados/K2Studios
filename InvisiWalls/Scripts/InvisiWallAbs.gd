extends StaticBody2D

var exists = true

onready var world
func _ready():
	var niveles = get_tree().get_nodes_in_group("Niveles")
	if niveles.size()>0:
		world=niveles[0]
func setUp(id):
	var players = world.players
	var ids = world.ids
	for i in range(len(players)):
		if ids[i] != id:
			add_collision_exception_with(players[i])
	var blocks = get_tree().get_nodes_in_group("Blocks")
	for block in blocks:
		add_collision_exception_with(block)
