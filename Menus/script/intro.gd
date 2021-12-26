extends Node2D

func _ready():
	$AnimationPlayer.play("Fade in")
	yield(get_tree().create_timer(1), "timeout")
	$IntroSound.play()
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("Fade out")
	yield(get_tree().create_timer(2), "timeout")
	
	LevelManager.change_scene_no_sfx(0) #res://Menus/Initial.tscn
