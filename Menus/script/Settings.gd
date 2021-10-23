extends Control

onready var PCSettings = $Sprite/ColorRect/Sprite
onready var SCSettings = $Sprite/ColorRect2/Sprite
onready var PCText = $Sprite/ColorRect
onready var SCText = $Sprite/ColorRect2

var standard 
var arrows 


func _ready():
	standard = Globals.current_settings[0]
	arrows = Globals.current_settings[1]
	$Sprite/ColorRect/button1.grab_focus()
	if not standard:
		PCSettings.frame = 0
		PCText.frame = PCSettings.frame
	if standard:
		PCSettings.frame = 1
		PCText.frame = PCSettings.frame
	if not arrows:
		SCSettings.frame = 0
		SCText.frame = SCSettings.frame
	if arrows:
		SCSettings.frame = 1
		SCText.frame = SCSettings.frame
		
	
func _on_button1_pressed():
	standard = !standard
	PCSettings.frame = (PCSettings.frame + 1)%2
	PCText.frame = PCSettings.frame
	Globals.current_settings=[standard,arrows]
	
		
func _on_button2_pressed():
	standard = !standard
	PCSettings.frame = (PCSettings.frame + 1)%2
	PCText.frame = PCSettings.frame
	Globals.current_settings=[standard,arrows]

func _on_button3_pressed():
	arrows = !arrows
	SCSettings.frame = (SCSettings.frame + 1)%2
	SCText.frame = SCSettings.frame
	Globals.current_settings=[standard,arrows]

func _on_button4_pressed():
	arrows = !arrows
	SCSettings.frame = (SCSettings.frame + 1)%2
	SCText.frame = SCSettings.frame
	Globals.current_settings=[standard,arrows]

func _on_Back_pressed():
	visible = false
	if get_parent().name == "Interface":
		get_parent().get_node("Pausa").visible = true
	else:
		var actual_dir = "res://Menus/Initial.tscn"
		get_tree().change_scene(actual_dir)
		
