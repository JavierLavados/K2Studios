extends Control

onready var  opcions =[$Sprite/Continue,$Sprite/Restart,$Sprite/Map,$Sprite/Controls,$Sprite/Salir]

var current_botton = 0


func _ready():
	var style = StyleBoxFlat.new()
	var color = Color(1, 0.5, 0)
	style.set_bg_color(color)
	$Sprite/Continue.set("custom_styles/normal", style)
	

func _input(event):
	if event.is_action_pressed("Pause"):
		var new_paused_state = not get_tree().paused
		get_tree().paused = new_paused_state
		visible = new_paused_state
		
	if event.is_action_pressed("Enter") and current_botton == 0:
		if get_tree().paused == true:
			visible = false
			get_tree().paused = false
	
	if event.is_action_pressed("Enter") and current_botton == 1:
		if get_tree().paused == true:
			get_tree().paused = false
			visible = false
			get_tree().reload_current_scene()
		
	if event.is_action_pressed("Enter") and current_botton == 2:
		if get_tree().paused == true:	
			get_tree().paused = false
			var format_dir = "res://Menus/MapWorld%s.tscn"
			var actual_dir = format_dir % str(Globals.current_world)
			get_tree().change_scene(actual_dir)
		
	if event.is_action_pressed("Enter") and current_botton == 4:
		if get_tree().paused == true:	
			get_tree().paused = false
			var actual_dir = "res://Menus/Initial.tscn"
			get_tree().change_scene(actual_dir)
	
	if event.is_action_pressed("ui_up"):
		var style = StyleBoxFlat.new()
		var color = Color(0, 0, 0)
		style.set_bg_color(color)
		opcions[current_botton].set("custom_styles/normal", style)
		
		current_botton=(current_botton-1)%5
		var style2 = StyleBoxFlat.new()
		var color2 = Color(1, 0.5, 0)
		style2.set_bg_color(color2)
		opcions[current_botton].set("custom_styles/normal", style2)
		
	
	if event.is_action_pressed("ui_down"):
		var style = StyleBoxFlat.new()
		var color = Color(0, 0, 0)
		style.set_bg_color(color)
		opcions[current_botton].set("custom_styles/normal", style)
		
		current_botton=(current_botton+1)%5
		var style2 = StyleBoxFlat.new()
		var color2 = Color(1, 0.5, 0)
		style2.set_bg_color(color2)
		opcions[current_botton].set("custom_styles/normal", style2)
	
	print(current_botton)
	
	
			
		
	

	
	
				
		

	
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
		var format_dir = "res://Menus/MapWorld%s.tscn"
		var actual_dir = format_dir % str(Globals.current_world)
		get_tree().change_scene(actual_dir)
		

func _on_Salir_pressed():
	if get_tree().paused == true:	
		get_tree().paused = false
		var actual_dir = "res://Menus/Initial.tscn"
		get_tree().change_scene(actual_dir)
