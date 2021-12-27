extends Node2D

onready var sprite = $Sprite

#export var required = 1
#export var level_proyect_dir = 'res://Levels/World1/Level1-1.tscn'
export var level_number = 1

export var up = false
export var right = false
export var down = false
export var left = false

var directions = []
var status

#var disabled = true
var body_inside = false

func _ready():
	
	sprite.frame = level_number - 1
	status = Globals.levels_status[level_number-1]
	if status:
		sprite.frame += 50
		
	directions = [up,right,down,left]

func _input(event):
	if event.is_action_pressed("ui_accept") and body_inside:
		#if not disabled and level_proyect_dir != '':
		#if level_proyect_dir != '':
		Globals.current_level=level_number
		LevelManager.change_scene(level_number+3)
		MusicManager.change_music(1)
		#get_tree().change_scene(level_proyect_dir)
		
		

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
