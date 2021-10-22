extends Control

onready var playback = $AnimationTree.get("parameters/playback")
onready var sprite = $Sprite

var active = 0
var cherry_controls = false

var w1 = "res://Sprites/SelectorTransparent.png"
var w2 = "res://Sprites/SelectorWorld2.png"
var w3 = "res://Sprites/SelectorHell.png"
var textures = [w1, w2, w3]

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
			
	if cherry_controls:
		$Sprite.modulate = Color(1,0.7,0.7)
	else:
		$Sprite.modulate = Color(1,1,1)


