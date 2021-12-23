extends Node2D


func _ready():
	pass 


func _on_Back_pressed():
	visible = false
	if get_parent().name == "Interface":
		get_parent().get_node("Pausa").visible = true
	else:
		var actual_dir = "res://Menus/Initial.tscn"
		get_tree().change_scene(actual_dir)
