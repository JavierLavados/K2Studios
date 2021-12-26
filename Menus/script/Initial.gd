extends Control

#onready var TRANSITION = get_node("Transition1")

func _ready():
	$VBoxContainer/Play.grab_focus()
	if len(Globals.levels_status)==0:
		for i in range(50):
			Globals.levels_status+=[false]
	if len(Globals.path_status)==0:
		for i in range(66):
			Globals.path_status+=[false]
	
func _input(event):
	if event.is_action_pressed("Esc"):
		get_tree().quit()
		#TRANSITION.quit_scene()

func _on_Play_pressed():
	#var format_dir = "res://MapInterface/maps/MapWorld%s.tscn"
	#var actual_dir = format_dir%str(Globals.current_world)
	get_tree().change_scene("res://MapInterface/WorldMaps/WorldMaps.tscn")
	#TRANSITION.change_scene_loc("res://MapInterface/WorldMaps/WorldMaps.tscn")
		
func _on_Settings_pressed():
	get_tree().change_scene("res://Menus/Settings.tscn")
	#TRANSITION.change_scene_loc("res://Menus/Settings.tscn")

func _on_Play_mouse_entered():
	$VBoxContainer/Play.grab_focus()
	
	
func _on_Settings_mouse_entered():
	$VBoxContainer/Settings.grab_focus()
	
func _on_Credits_pressed():
	get_tree().change_scene("res://Menus/Credits.tscn")
	#TRANSITION.change_scene_loc("res://Menus/Credits.tscn")

func _on_Credits_mouse_entered():
	$VBoxContainer/Credits.grab_focus()


func _on_Exit_pressed():
	get_tree().quit()

func _on_Exit_mouse_entered():
	$VBoxContainer/Exit.grab_focus()
