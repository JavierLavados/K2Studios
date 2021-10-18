extends Control

onready var Continue = $Sprite/Continue
onready var Restart = $Sprite/Restart
onready var Map = $Sprite/Map

var current_botton = Continue

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
		var format_dir = "res://Selector/Selector%s.tscn"
		var actual_dir = format_dir % str(Globals.current_world)
		get_tree().change_scene(actual_dir)
		

