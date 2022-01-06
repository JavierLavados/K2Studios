extends Node

export (Array, PackedScene) var paths

var scene : Node

func _ready():
	# hacer un for para llenar el paths con los niveles
	pass 

func change_scene(index):
	
	if index >= 0 and index < paths.size():
		
		scene.change_scene_loc(paths[index].instance())
	
		
func change_scene_no_sfx(index):

	if index >= 0 and index < paths.size():
		scene.change_scene(paths[index].instance())
		
		
var codigo = "JJJ"
var collected_keys = ""

func _process(delta):
	if Input.is_action_just_pressed("J"):
		collected_keys+="J"
		_wakeup_Timer()
		
func _wakeup_Timer():
	$Timer.wait_time = 0.3
	$Timer.start()

func _on_Timer_timeout():
	$Timer.stop()
	if collected_keys==codigo:
		#print(scene.get_child(0).get_child(0).name)
		#if "Initial" in scene.get_child(0).get_child(0).name:
		Globals.current_points=60
		for i in range(0,len(Globals.levels_status)):
			Globals.levels_status[i]=true
		for i in range(0,len(Globals.path_status)):
			Globals.path_status[i]=true
		for i in range(0,len(Globals.block_status)):
			Globals.block_status[i]=true


