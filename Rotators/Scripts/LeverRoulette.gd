extends Node2D

onready var playback = $AnimationTree.get("parameters/playback")
onready var sprite = $Sprite

func _ready():
	if Globals.current_world == 5:
		sprite.texture = load("res://Sprites/RotatorW5.png")
	else:
		sprite.texture = load("res://Sprites/RotatorW4.png")
		
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
