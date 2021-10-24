extends Node2D

var exists = true
var movement

func _process(delta):
	if movement:
		position.x -= movement.x * 300 * delta
		position.y -= movement.y * 300 * delta
	if not exists:
		queue_free()

func _on_Timer_timeout():
	exists = false
