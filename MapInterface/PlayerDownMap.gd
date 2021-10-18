extends KinematicBody2D

onready var sprite = $Sprite

var order = 2
var pointer
var positions
var gap
var on_node = true

func _ready():
	pointer = get_parent()
	gap = pointer.gap

func _physics_process(delta):
	
	if on_node:
		sprite.frame = 0
	else:
		sprite.frame = 10
		
	if (len(pointer.positions) - 1) >= gap*(3-order):
		global_position = pointer.positions[gap*(3-order)]
