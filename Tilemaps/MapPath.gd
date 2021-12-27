extends Node2D

onready var sprite = $Sprite

export var vertical = false
export var adjacent = [0,0]
export var directions = ["R","L"]

var active = 0
var expand = false

var status_path
export var id = 0

var adjacent_nodes = []

func _ready():
	
	if vertical:
		sprite.frame += 1
		sprite.scale.y *= 2
	else:
		sprite.scale.x *= 2
		
	sprite.frame += (Globals.current_world-1)*3
	
	for i in get_tree().get_nodes_in_group("LevelIcons"):
		if i.level_number in adjacent:
			adjacent_nodes.append(i)
	
	for i in adjacent_nodes:
		if i.status:
			active += 1
	
	if active > 0:
		sprite.visible = true

		for i in range(2):
			var j = 0
			match directions[i]:
				"U":
					j = 0
				"R":
					j = 1
				"D":
					j = 2
				"L":
					j = 3	
			adjacent_nodes[i].directions[j] = true
	else:
		sprite.visible = false
	
	status_path=Globals.path_status[id-1]
	if active < len(adjacent) and status_path==false and active>0:
		expand = true
		Globals.path_status[id-1]=true
		if vertical:
			sprite.scale.y = 0
		else:
			sprite.scale.x = 0
	

func _process(delta):
	if expand:
		if vertical:
			sprite.scale.y += delta * 4
		else:
			sprite.scale.x += delta * 4
	
	if sprite.scale.y >= 4 or sprite.scale.x >= 4:
		expand = false
		
	sprite.frame = (Globals.current_world-1)*3
	if vertical:
		sprite.frame += 1
	
			
	
	

