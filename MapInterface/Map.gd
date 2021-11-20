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

func _on_Next_body_entered(body):
	Globals.current_level = 1
	Globals.current_world=Globals.current_world+1
	yield(get_tree().create_timer(0.6), "timeout")
	var format_dir = "res://MapInterface/maps/MapWorld%s.tscn"
	var actual_dir = format_dir%str(Globals.current_world)
	get_tree().change_scene(actual_dir)


func _on_Back_body_entered(body):
	if Globals.current_world>1:
		Globals.current_level = 4
		Globals.current_world=Globals.current_world-1
		var format_dir = "res://MapInterface/maps/MapWorld%s.tscn"
		var actual_dir = format_dir%str(Globals.current_world)
		get_tree().change_scene(actual_dir)
