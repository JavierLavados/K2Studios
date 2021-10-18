extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.current_level>=10:
		disabled = false
	else:
		disabled = true
		
func _on_Next_pressed():
		get_tree().change_scene("res://Selector/Selector2.tscn")
