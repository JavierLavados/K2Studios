extends Node2D

export var required = 1
#var bloqued
func _ready():
	var decima = required/10+(Globals.current_world-1)*10
	var unidad = required%10+(Globals.current_world-1)*10
	if decima == 0:
		$Sprite2/Decima.visible=false
		$Sprite2/Unidad.frame=unidad
		$Sprite2/Unidad.position.x=0
	if decima !=0:
		$Sprite2/Decima.frame=decima
		$Sprite2/Unidad.frame=unidad

	if required<= Globals.current_points:
		#bloqued = false
		visible = false
	else:
		#bloqued = true
		visible = true
func _on_Area2D_body_entered(body):
	if visible:
		body.go_back=true
	

