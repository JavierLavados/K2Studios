extends RigidBody2D

onready var sprite = $Sprite

var NORMAL = Vector2(0,1)
var id = 2

func _ready():
	sprite.frame = (4*(Globals.current_world-1)) + id

