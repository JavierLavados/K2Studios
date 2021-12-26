extends AudioStreamPlayer

export var music = ""



func _ready():
	var musicaFondo = load(music)
	set_stream(musicaFondo)
	set_volume_db(-20)
	if not self.playing:
		play()
