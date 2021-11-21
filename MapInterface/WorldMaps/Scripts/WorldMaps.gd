extends Node2D


var level_total = 20
onready var pointer = $MapPointer

func _ready():
	$Camera2D.set_position(Vector2(512+1024*(Globals.current_world-1),320))
	
	var icons = get_tree().get_nodes_in_group("LevelIcons")
	var current_level = Globals.current_level
	
	for i in range(level_total):
		if icons[i].level_number == current_level:
			pointer.current_node = icons[i]
			break

func _on_Transition12_body_entered(body):
	
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<1024:
		Globals.current_level = 11
		Globals.current_world=Globals.current_world+1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+1024,320))
	else:
		Globals.current_level = 10
		Globals.current_world=Globals.current_world-1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512,320))


func _on_Transition23_body_entered(body):
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<2048:
		Globals.current_world=Globals.current_world+1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+2048,320))
	else:
		Globals.current_world=Globals.current_world-1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+1024,320))
