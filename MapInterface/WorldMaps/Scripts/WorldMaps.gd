extends Node2D

onready var pointer = $MapPointer
onready var background = $Background


var level_total = 50

func _ready():

	$Counter/Decena.frame=(int(Globals.current_points)/10)+10*(int(Globals.current_world)-1)
	$Counter/Unidad.frame=int(Globals.current_points)%10+10*(int(Globals.current_world)-1)
	$Counter.frame=int(Globals.current_world)-1
	
	$Camera2D.set_position(Vector2(512+1024*(Globals.current_world-1),320))
	background.position.x = 1024*(Globals.current_world-1)
	$Counter.position.x = 1024*(Globals.current_world-1)+960

	
	var icons = get_tree().get_nodes_in_group("LevelIcons")
	var current_level = Globals.current_level
	
	for i in range(level_total):
		if icons[i].level_number == current_level:
			pointer.current_node = icons[i]
			break

func _input(event):
	if event.is_action_pressed("Esc"):
		#get_tree().change_scene("res://Menus/Initial.tscn")
		LevelManager.change_scene_no_sfx(0) #res://Menus/Initial.tscn

func transition():
	var pos = $MapPointer.marker.global_position
	if int(pos.x)%1024>512:
		Globals.current_level = Globals.current_world*10+1
		Globals.current_world = Globals.current_world+1
	else:
		Globals.current_level = (Globals.current_world-1)*10
		Globals.current_world = Globals.current_world-1
	yield(get_tree().create_timer(0.1), "timeout")
	background.position.x = 1024*(Globals.current_world-1)
	$Counter/Decena.frame = (int(Globals.current_points)/10)+10*(int(Globals.current_world)-1)
	$Counter/Unidad.frame = int(Globals.current_points)%10+10*(int(Globals.current_world)-1)
	$Counter.frame = int(Globals.current_world)-1
	$Counter.position.x = 1024*(Globals.current_world-1)+960
	background.world = Globals.current_world
	$Camera2D.set_position(Vector2(512+(Globals.current_world-1)*1024,320))

func _on_Transition1_body_entered(body):
	transition()

func _on_Transition2_body_entered(body):
	transition()

func _on_Transition3_body_entered(body):
	transition()

func _on_Transition4_body_entered(body):
	transition()
	
func _on_Transition5_body_entered(body):
	transition()
