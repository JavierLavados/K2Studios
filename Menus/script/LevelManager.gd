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


