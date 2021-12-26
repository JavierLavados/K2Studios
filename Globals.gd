extends Node

# cuando current_pointscambia llama a current_points_changed
var current_points= 0 setget current_points_changed
var current_world = 1 setget current_world_changed
var levels_status = [] setget levels_status_changed
var current_level = 1 setget current_level_changed
var current_settings =[false,false] setget current_settings_changed
var path_status = [] setget path_status_changed
var block_status = [] setget block_status_changed

# Json del juego
var data_game = {
	'current_points': current_points,
	'levels_status' : levels_status,
	'current_level': current_level,
	'current_settings':current_settings,
	'current_world': current_world,
	'path_status' : path_status,
	'block_status' : block_status
}
# Lo primero que hace es cargar el juego
func _ready():
	load_game()

# Funcion que cambia el actual nivel
func current_points_changed(points):
	current_points=points
	save_game()
	
func levels_status_changed(status):
	levels_status=status
	save_game()
	
func current_level_changed(level):
	current_level=level
	save_game()	
	
func current_settings_changed(settings):
	current_settings =settings
	save_game()

func current_world_changed(world):
	current_world = world
	save_game()
	
func path_status_changed(path):
	path_status = path
	save_game()
	
func block_status_changed(block):
	block_status = block
	save_game()
	
# Salva el juego
func save_game():
	
	data_game['current_points']=current_points
	data_game['levels_status']=levels_status
	data_game['current_level']=current_level
	data_game['current_settings']=current_settings
	data_game['current_world']=current_world
	data_game['path_status']=path_status
	data_game['block_status']=block_status
	
	var file = File.new()
	file.open('res://data.save',File.WRITE)
	file.store_line(to_json(data_game))
	file.close()
	
# carga el juego
func load_game():
	var file = File.new()
	if file.file_exists('res://data.save'):
		file.open('res://data.save',File.READ)
	else:
		return
	
	while file.get_position()< file.get_len():
		var dataJson = parse_json(file.get_line())
		current_points=dataJson['current_points']
		levels_status=dataJson['levels_status']
		current_level=dataJson['current_level']
		current_settings=dataJson['current_settings']
		current_world=dataJson['current_world']
		path_status=dataJson['path_status']
		block_status=dataJson['block_status']
	file.close()
	
	
	
		
