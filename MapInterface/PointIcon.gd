extends Node2D

export var left = false
export var right = false
export var up = false
export var down = false

var directions = []

#var disabled = true
var body_inside = false

func _ready():

	directions = [up,right,down,left]


func _on_Area2D_body_entered(body):
	body_inside = true
	body.on_node = true
	if body.name == "MapPointer":
		body.node_pos = global_position
		body.directions=directions
 
func _on_Area2D_area_entered(area):
	#print(area)
	if not area.get_parent().is_in_group("BlockIcons"):
		area.get_parent().on_node = true
	
func _on_Area2D_body_exited(body):
	body_inside = false
	#body.directions = null
