extends Node

export (Array, PackedScene) var paths

var scene : Node

func _ready():
	# hacer un for para llenar el paths con los niveles
	pass 

func change_music(index):
	if index >= 0 and index < paths.size():	
		scene.change_music(paths[index].instance())
