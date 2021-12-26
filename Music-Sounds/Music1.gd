extends AudioStreamPlayer

var musicaFondo = load("res://Music-Sounds/music.mp3")


func _ready():
	pass 


func play_music():
	#$Music.stream = musicaFondo
	if not $Music.playing:
		$Music.play()
