extends "res://Levels/Scripts/LevelAbstract.gd"

var n_players = 4
var next = "res://MapInterface/Map.tscn"

func _ready():
	setUp(n_players,0,3)
	
func _physics_process(delta):
	level(n_players, next)
