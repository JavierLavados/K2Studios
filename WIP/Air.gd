extends Node2D

var exists = true

func _process(delta):
	position.y += delta * 200
	if not exists:
		queue_free()

func _on_Timer_timeout():
	exists = false
