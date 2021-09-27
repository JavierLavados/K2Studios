extends "res://scenes/PlayerAbstract.gd"

const NORMAL = Vector2(0, -1)
var cherry_controls = false

func _ready():
	initialize(NORMAL)
	
func _physics_process(delta):
	calc_motion(NORMAL, "right", "left", "up", "down")
	modify_sprite(NORMAL, "right", "left")
