extends Node2D

onready var sprite = $Sprite

export var level_number = 1

export var up = false
export var right = false
export var down = false
export var left = false

var directions = []
var status
var chars = 0

var body_inside = null

func _ready():
	
	sprite.frame = level_number-1
	status = Globals.levels_status[level_number-1]
	if status:
		sprite.frame += 60
		
	directions = [up,right,down,left]

func _input(event):
	if event.is_action_pressed("ui_accept") and body_inside:
		if not body_inside.get_parent().waiting:
			Globals.current_level = level_number
			LevelManager.change_scene(level_number+3)
			MusicManager.change_music(1)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Markers"):
		body_inside = body
		body.get_parent().current_node = self

func _on_Area2D_body_exited(body):
	body_inside = null

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("MapPlayers"):
		if area.get_parent().leave == 2:
			area.get_parent().leave = 3
		chars += 1

func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("MapPlayers"):
		chars -= 1
