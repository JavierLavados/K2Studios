extends "res://Levels/Scripts/LevelAbstract.gd"

var n_players = 4
var next = "res://MapInterface/Maps/MapWorld2.tscn"

func _ready():
	setUp(n_players)
	
func _physics_process(delta):
	level(n_players)
