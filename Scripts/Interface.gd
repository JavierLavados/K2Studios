extends Control

onready var playback = $AnimationTree.get("parameters/playback")

var active = 0

func _physics_process(delta):
	match active:
		0:
			playback.travel("Up")
		1:
			playback.travel("Right")
		2:
			playback.travel("Down")
		3:
			playback.travel("Left")
