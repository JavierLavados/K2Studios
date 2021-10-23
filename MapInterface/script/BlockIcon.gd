extends Node2D

export var required = 1

func _ready():
	if required<= Globals.current_points:
		visible = false
	else:
		visible = true
		
func _on_Area2D_body_entered(body):
	if visible:
		body.go_back=true
	

