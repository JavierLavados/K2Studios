extends "res://MapInterface/PlayerMapAbstract.gd"

var texture = "res://Sprites/GuySprites/DownGuy/DownMapW"
var id = 2
var target = Vector2(-16,-20)

func _ready():
	setUp(texture)

func _physics_process(delta):
	playerMap(texture, id, target)

