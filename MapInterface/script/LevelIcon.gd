extends Node2D

export var required = 1
export var level_proyect_dir = ''
var disabled = true
var dentro = false

func _ready():
	if required<= Globals.current_points:
		disabled = false
	else:
		disabled = true
		
func _input(event):
	if event.is_action_pressed("ui_accept") and dentro:
		if not disabled and level_proyect_dir != '':
			get_tree().change_scene(level_proyect_dir)
		
		

func _on_Area2D_body_entered(body):
	dentro = true
	body.on_node = true
	if body.name == "MapPointer":
		body.node_pos = global_position

func _on_Area2D_area_entered(area):
	area.get_parent().on_node = true
	
func _on_Area2D_body_exited(body):
	dentro = false
