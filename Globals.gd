extends Node

# cuando current_pointscambia llama a current_points_changed
var current_points= 1 setget current_points_changed
var current_world = 1



# Json del juego
var data_game = {
	'current_points': current_points
}

# Lo primero que hace es cargar el juego
func _ready():
	load_game()

# Funcion que cambia el actual nivel
func current_points_changed(points):
	current_points=points
	data_game['current_points']=current_points
	save_game()
	
# Salva el juego
func save_game():
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
	file.close()
	
		
	
	
