extends Node2D


func _ready():
	pass 

func _on_TextureButton_pressed():
	
	LevelManager.change_scene_no_sfx(0) #res://Menus/Initial.tscn
