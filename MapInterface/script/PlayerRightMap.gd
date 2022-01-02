extends "res://MapInterface/PlayerMapAbstract.gd"

var texture = "res://Sprites/GuySprites/RightGuy/RightMapW"
var id = 1
var target = Vector2(16,6)

func _ready():
	setUp(texture)

func _physics_process(delta):
	playerMap(texture, id, target)
