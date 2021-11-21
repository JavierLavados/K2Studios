extends Node2D

export var required = 1
#var bloqued
func _ready():
	if required<= Globals.current_points:
		#bloqued = false
		visible = false
	else:
		#bloqued = true
		visible = true
func _on_Area2D_body_entered(body):
	if visible:
		body.go_back=true
	

