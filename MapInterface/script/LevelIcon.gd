extends Node2D

onready var sprite = $Sprite

#export var required = 1
export var level_proyect_dir = ''
export var level_number = 1

export var left = false
export var right = false
export var up = false
export var down = false

var directions = []


#var disabled = true
var body_inside = false

func _ready():
	
	sprite.frame = level_number - 1
	directions = [up,right,down,left]
	#if required<= Globals.current_points:
	#	disabled = false
	#else:
		#disabled = true
		
func _input(event):
	if event.is_action_pressed("ui_accept") and body_inside:
		#if not disabled and level_proyect_dir != '':
		if level_proyect_dir != '':
			Globals.current_level=level_number
			get_tree().change_scene(level_proyect_dir)
		
		

func _on_Area2D_body_entered(body):
	body_inside = true
	body.on_node = true
	if body.name == "MapPointer":
		body.node_pos = global_position
		body.directions=directions

func _on_Area2D_area_entered(area):
	area.get_parent().on_node = true
	
func _on_Area2D_body_exited(body):
	body_inside = false
	#body.directions = null
