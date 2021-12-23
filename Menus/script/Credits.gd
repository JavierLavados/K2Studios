extends Node2D


func _ready():
	pass 

func _on_TextureButton_pressed():
	var actual_dir = "res://Menus/Initial.tscn"
	get_tree().change_scene(actual_dir)
