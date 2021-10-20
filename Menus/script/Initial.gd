extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Play.grab_focus()

func _on_Play_pressed():
		var actual_dir = "res://Menus/MapWorld1.tscn"
		get_tree().change_scene(actual_dir)
		
#func _on_Opcions_pressed():
#	var actual_dir = "res://Menus/Options.tscn"
#	get_tree().change_scene(actual_dir)
	
func _on_Play_mouse_entered():
	$VBoxContainer/Play.grab_focus()
	
	
#func _on_Opcions_mouse_entered():
	#$Sprite/VBoxContainer/Opcions.grab_focus()
