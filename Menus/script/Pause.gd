extends Control

func _ready():
	$Sprite/VBoxContainer/Continue.grab_focus()
	

func _input(event):
	if event.is_action_pressed("Pause"):
		var new_paused_state = not get_tree().paused
		get_tree().paused = new_paused_state
		visible = new_paused_state


func _on_Continue_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		visible = false


func _on_Restart_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		visible = false
		get_tree().reload_current_scene()
	

func _on_Map_pressed():
	if get_tree().paused == true:	
		get_tree().paused = false
		var actual_dir = "res://MapInterface/Map.tscn"
		#var actual_dir = format_dir % str(Globals.current_world)
		get_tree().change_scene(actual_dir)
		
func _on_Opcions_pressed():
	var actual_dir = "res://Menus/Options.tscn"
	get_tree().change_scene(actual_dir)


func _on_Salir_pressed():
	if get_tree().paused == true:	
		get_tree().paused = false
		var actual_dir = "res://Menus/Initial.tscn"
		get_tree().change_scene(actual_dir)


func _on_Continue_mouse_entered():
	$Sprite/VBoxContainer/Continue.grab_focus()

func _on_Restart_mouse_entered():
	$Sprite/VBoxContainer/Restart.grab_focus()

func _on_Map_mouse_entered():
	$Sprite/VBoxContainer/Map.grab_focus()


func _on_Opcions_mouse_entered():
	$Sprite/VBoxContainer/Opcions.grab_focus()

func _on_Salir_mouse_entered():
	$Sprite/VBoxContainer/Salir.grab_focus()






