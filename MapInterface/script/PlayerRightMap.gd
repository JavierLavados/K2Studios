extends KinematicBody2D

onready var sprite = $Sprite

var order = 1
var pointer
var positions
var gap
var on_node = true

var texture = "res://Sprites/GuySprites/RightGuy/RightMapW"

func _ready():
	var t = texture + str(Globals.current_world) + ".png"
	sprite.texture = load(t)
	
	pointer = get_parent()
	gap = pointer.gap

func _physics_process(delta):
	var t = texture + str(Globals.current_world) + ".png"
	sprite.texture = load(t)
	
	if on_node:
		sprite.frame = 0
		sprite.flip_h = false
	else:
		if pointer.dir == 0:
			sprite.frame = 11
		else:
			if pointer.dir == 2:
				sprite.frame = 12
			else:
				sprite.frame = 10
				if pointer.dir == 1:
					sprite.flip_h = false
				else:
					sprite.flip_h = true
		
	if not pointer.on_node or pointer.waiting:
		if (len(pointer.positions) - 1) >= gap*(3-order):
			global_position = pointer.positions[gap*(3-order)]
			
	if on_node:
		position = Vector2(16,6)

