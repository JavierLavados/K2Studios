extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _ready():
	sprite.rotation_degrees = 90
	animationPlayer.play("Move")

func _process(delta):
	animationPlayer.play("Move")
