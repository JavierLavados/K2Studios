extends Node2D


var level_total = 50
onready var pointer = $MapPointer

func _ready():
	$Label.text=str(Globals.current_points)
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
		Globals.current_level = 21
		Globals.current_world=Globals.current_world+1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+2048,320))
	else:
		Globals.current_level = 20
		Globals.current_world=Globals.current_world-1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+1024,320))


func _on_Transition34_body_entered(body):
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<3072:
		Globals.current_level = 31
		Globals.current_world=Globals.current_world+1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+3072,320))
	else:
		Globals.current_level = 30
		Globals.current_world=Globals.current_world-1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+2048,320))


func _on_Transition45_body_entered(body):
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<4096:
		Globals.current_level = 41
		Globals.current_world=Globals.current_world+1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+4096,320))
	else:
		Globals.current_level = 40
		Globals.current_world=Globals.current_world-1
		yield(get_tree().create_timer(0.1), "timeout")
		$Camera2D.set_position(Vector2(512+3072,320))
