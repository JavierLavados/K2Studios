extends Node2D

onready var sprite = $Sprite

export var left = false
export var right = false
export var up = false
export var down = false

var directions = []

var body_inside = false
var chars = 0

func _ready():
	sprite.frame = Globals.current_world-1
	directions = [up,right,down,left]

func _process(delta):
	sprite.frame = Globals.current_world-1

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
