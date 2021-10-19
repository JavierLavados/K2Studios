extends Node2D

onready var playback = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	match get_parent().lever:
		0:
			playback.travel("Up")
		1:
			playback.travel("Right")
		2:
			playback.travel("Down")
		3:
			playback.travel("Left")
