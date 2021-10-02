extends StaticBody2D

var exists = true

func _process(delta):
	if not exists:
		queue_free()
