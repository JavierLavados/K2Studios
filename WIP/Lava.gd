extends Area2D

onready var anim = $AnimationPlayer

func _ready():
	anim.current_animation = "Main"

