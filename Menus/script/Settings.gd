extends Control

onready var PCSettings = $Sprite/ColorRect/Sprite
onready var SCSettings = $Sprite/ColorRect2/Sprite
onready var PCText = $Sprite/ColorRect
onready var SCText = $Sprite/ColorRect2

var standard = true
var arrows = true

func _ready():
	$Sprite/ColorRect/button1.grab_focus()
	
func _on_button1_pressed():
	standard = !standard
	PCSettings.frame = (PCSettings.frame + 1)%2
	PCText.frame = PCSettings.frame
		
func _on_button2_pressed():
	standard = !standard
	PCSettings.frame = (PCSettings.frame + 1)%2
	PCText.frame = PCSettings.frame

func _on_button3_pressed():
	arrows = !arrows
	SCSettings.frame = (SCSettings.frame + 1)%2
	SCText.frame = SCSettings.frame

func _on_button4_pressed():
	arrows = !arrows
	SCSettings.frame = (SCSettings.frame + 1)%2
	SCText.frame = SCSettings.frame

func _on_Back_pressed():
	visible = false
	get_parent().get_node("Pausa").visible = true
