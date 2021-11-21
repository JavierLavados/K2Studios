extends Control

func _ready():
	$Sprite/VBoxContainer/Resume.grab_focus()
	
func _input(event):
	if event.is_action_pressed("Esc"):
		var conf_status = get_parent().get_node("Setting").visible
		if not conf_status:
			var new_paused_state = not get_tree().paused
			get_tree().paused = new_paused_state
			visible = new_paused_state
		elif conf_status:
			get_parent().get_node("Setting").visible=false
			visible=true
			
			

func _on_Resume_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		visible = false

func _on_Restart_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
		visible = false
		get_tree().reload_current_scene()

func _on_LevelSel_pressed():
	if get_tree().paused == true:	
		get_tree().paused = false
		#var format_dir = "res://MapInterface/maps/MapWorld%s.tscn"
		#var actual_dir = format_dir%str(Globals.current_world)
		get_tree().change_scene("res://MapInterface/WorldMaps/WorldMaps.tscn")
		
func _on_Settings_pressed():
	if get_tree().paused == true:	
		visible=false
		get_parent().get_node("Setting").visible=true
	
	

func _on_TitleScr_pressed():
	if get_tree().paused == true:	
		get_tree().paused = false
		var actual_dir = "res://Menus/Initial.tscn"
		get_tree().change_scene(actual_dir)


func _on_Resume_mouse_entered():
	$Sprite/VBoxContainer/Resume.grab_focus()

func _on_Restart_mouse_entered():
	$Sprite/VBoxContainer/Restart.grab_focus()

func _on_LevelSel_mouse_entered():
	$Sprite/VBoxContainer/LevelSel.grab_focus()

func _on_Settings_mouse_entered():
	$Sprite/VBoxContainer/Settings.grab_focus()

func _on_TitleScr_mouse_entered():
	$Sprite/VBoxContainer/TitleScr.grab_focus()

