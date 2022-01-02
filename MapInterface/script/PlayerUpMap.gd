extends "res://MapInterface/PlayerMapAbstract.gd"

var texture = "res://Sprites/GuySprites/UpGuy/UpMapW"
var id = 0
var target = Vector2(16,-20)

func _ready():
	setUp(texture)

func _physics_process(delta):
	playerMap(texture, id, target)
