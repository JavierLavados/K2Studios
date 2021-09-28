extends Area2D

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
			if body in get_parent().players:
				body.doubleJump = true
			get_parent().remove_child(self)
