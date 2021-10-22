extends "res://Levels/Scripts/LevelAbstract.gd"

var n_players = 1
var next = "res://MapInterface/Map.tscn"

func _ready():
	setUp(n_players)
	
func _physics_process(delta):
	level(n_players, next)
