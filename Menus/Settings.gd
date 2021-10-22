extends Control

onready var controllerOp1 = $Sprite/ColorRect/Sprite
onready var controllerOp2 = $Sprite/ColorRect/Sprite2
onready var SelectionOp1 = $Sprite/ColorRect2/Sprite
onready var SelectionOp2 = $Sprite/ColorRect2/Sprite2

var standard = true
var arrows = true


func _on_button1_pressed():
	print("cambioooooooooooooooo")
	if standard == true:
		standard=false
		controllerOp1.visible=false
		controllerOp2.visible=true
	else:
		standard=true
		controllerOp1.visible=true
		controllerOp2.visible=false
		
func _on_button2_pressed():
	if standard == true:
		standard=false
		controllerOp1.visible=false
		controllerOp2.visible=true
	else:
		standard=true
		controllerOp1.visible=true
		controllerOp2.visible=false


func _on_button3_pressed():
	if arrows == true:
		arrows=false
		SelectionOp1.visible=false
		SelectionOp2.visible=true
	else:
		arrows=true
		SelectionOp1.visible=true
		SelectionOp2.visible=false


func _on_button4_pressed():
	if arrows == true:
		arrows=false
		SelectionOp1.visible=false
		SelectionOp2.visible=true
	else:
		arrows=true
		SelectionOp1.visible=true
		SelectionOp2.visible=false


func _on_Button_pressed():
	visible=false
	get_parent().get_node("Pausa").visible=true
