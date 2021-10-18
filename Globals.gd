extends Node

# cuando current_level cambia llama a current_level_changed
var current_level = 1 setget current_level_changed
var current_world = 1



# Json del juego
var data_game = {
	'current_level': current_level
}

# Lo primero que hace es cargar el juego
func _ready():
	load_game()

# Funcion que cambia el actual nivel
func current_level_changed(level):
	current_level=level
	data_game['current_level']=current_level
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
		current_level=dataJson['current_level']
	file.close()
	
		
	
	
