extends CanvasLayer

onready var animPlayer = $AnimationPlayer

func change_scene_loc(path):
	layer = 1
	# blur in
	animPlayer.play("blur_in")
	yield(animPlayer, "animation_finished")
	# cambio de escena
	get_tree().change_scene(path)
	# blur out
	animPlayer.play_backwards("blur_out")
	yield(animPlayer, "animation_finished")
	layer = -1
	
func quit_scene():
	layer = 1
	# blur in
	animPlayer.play("blur_in")
	yield(animPlayer, "animation_finished")
	# cambio de escena
	get_tree().quit()
	animPlayer.play_backwards("blur_out")
	yield(animPlayer, "animation_finished")
	layer = -1
	

func _ready():
	layer = -1
	


