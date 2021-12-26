extends Control


func _ready():
	$VBoxContainer/Play.grab_focus()
	if len(Globals.levels_status)==0:
		for i in range(50):
			Globals.levels_status+=[false]
	if len(Globals.path_status)==0:
		for i in range(66):
			Globals.path_status+=[false]
	if len(Globals.block_status)==0:
		for i in range(10):
			Globals.block_status+=[false]
	
func _input(event):
	if event.is_action_pressed("Esc"):
		get_tree().quit()
		#TRANSITION.quit_scene()

func _on_Play_pressed():
	#get_tree().change_scene("res://MapInterface/WorldMaps/WorldMaps.tscn")
	LevelManager.change_scene(3) #res://MapInterface/WorldMaps/WorldMaps.tscn
		
func _on_Settings_pressed():
	#get_tree().change_scene("res://Menus/Settings.tscn")
	LevelManager.change_scene_no_sfx(1) #res://Menus/Settings.tscn
	

func _on_Play_mouse_entered():
	$VBoxContainer/Play.grab_focus()
	
	
func _on_Settings_mouse_entered():
	$VBoxContainer/Settings.grab_focus()
	
func _on_Credits_pressed():
	#get_tree().change_scene("res://Menus/Credits.tscn")
	LevelManager.change_scene_no_sfx(2) #res://Menus/Credits.tscn

func _on_Credits_mouse_entered():
	$VBoxContainer/Credits.grab_focus()


func _on_Exit_pressed():
	get_tree().quit()

func _on_Exit_mouse_entered():
	$VBoxContainer/Exit.grab_focus()
