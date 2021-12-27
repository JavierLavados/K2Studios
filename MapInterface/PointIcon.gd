extends Node2D

onready var sprite = $Sprite

export var left = false
export var right = false
export var up = false
export var down = false

var directions = []

#var disabled = true
var body_inside = false

func _ready():
	sprite.frame = Globals.current_world-1
	directions = [up,right,down,left]


func _process(delta):
	sprite.frame = Globals.current_world-1

func _on_Area2D_body_entered(body):
	body_inside = true
	body.on_node = true
	if body.name == "MapPointer":
		body.node_pos = global_position
		body.directions=directions
 
func _on_Area2D_body_exited(body):
	body_inside = false
	#body.directions = null


func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("MapPlayers"):
		area.get_parent().on_node = true


		
