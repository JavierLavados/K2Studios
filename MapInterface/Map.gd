extends Node2D

export var level_total = 4

onready var pointer = $MapPointer

func _ready():
	
	var icons = get_tree().get_nodes_in_group("LevelIcons")
	var current_level = Globals.current_level

	for i in range(level_total):
		if icons[i].level_number == current_level:
			pointer.current_node = icons[i]
			break
	#print(pointer.node_pos)

			
			
			
	
		
