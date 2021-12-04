extends Node2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

var id = 0
var route = "res://Sprites/KeysW"

func _ready():
	var texture = route + str(Globals.current_world) + ".png"
	sprite.texture = load(texture)

func _process(delta):
	match id:
		0:
			anim.current_animation = "Up"
		1:
			anim.current_animation = "Right"
		2:
			anim.current_animation = "Down"
		3:
			anim.current_animation = "Left"
