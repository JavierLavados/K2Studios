extends Node2D

var leader
var positions = []
var gap = 10

func _ready():
	leader = get_parent()

func _process(delta):
	
	if len(leader.positions) > 0:
		global_position = leader.positions[0]
	
	if len(positions) > gap:
		positions.pop_front()
	positions.append(global_position)
	
