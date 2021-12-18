extends RigidBody2D

onready var sprite = $Sprite

var NORMAL = Vector2(-1,0)
var id = 3

func _ready():
	sprite.frame = (4*(Globals.current_world-1)) + id

