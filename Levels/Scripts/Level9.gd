extends "res://Levels/Scripts/LevelAbstract.gd"

var n_players = 4
var next = "res://Levels/Level1.tscn"

func _ready():
	setUp(n_players,2)
	
func _physics_process(delta):
	level(n_players, next)
