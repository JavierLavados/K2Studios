extends Control


func _ready():
	$VBoxContainer/Play.grab_focus()
	
func _input(event):
	if event.is_action_pressed("Esc"):
		get_tree().quit()

func _on_Play_pressed():
	var actual_dir = "res://MapInterface/Map.tscn"
	get_tree().change_scene(actual_dir)
		
func _on_Settings_pressed():
	var actual_dir = "res://Menus/Settings.tscn"
	get_tree().change_scene(actual_dir)
		
		
#func _on_Salir_pressed():
	#get_tree().quit()
	
func _on_Play_mouse_entered():
	$VBoxContainer/Play.grab_focus()
	
	
func _on_Settings_mouse_entered():
	$VBoxContainer/Settings.grab_focus()
	
#func _on_Salir_mouse_entered():
	#$VBoxContainer/Salir.grab_focus()




