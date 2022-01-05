extends Node2D

func _on_Space1_pressed():
	Globals.n_save=1
	Globals.load_game()
	LevelManager.change_scene_no_sfx(3)


func _on_Space2_pressed():
	Globals.n_save=2
	Globals.load_game()
	LevelManager.change_scene_no_sfx(3)


func _on_Space3_pressed():
	Globals.n_save=3
	Globals.load_game()
	LevelManager.change_scene_no_sfx(3)
