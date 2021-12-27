extends Node

onready var newRoot = $newRoot
onready var transition = $Transition1
onready var animPlayer = transition.animPlayer
onready var music = $music

onready var tween : Tween = transition.tween

func _ready():
	
	LevelManager.scene = self
	MusicManager.scene = self


func change_music(scene:Node):
	music.get_child(0).queue_free()
	music.add_child(scene)

func change_scene(scene:Node):	
	newRoot.get_child(0).queue_free()
	newRoot.add_child(scene)

func change_scene_loc(scene:Node):
	transition.layer = 1
	# blur in
	tween.interpolate_property(transition.we, "environment:dof_blur_near_amount", 0, 1, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#tween.interpolate_property(transition.cr, "color", Color(0,0,0,0), Color(0,0,0,1), 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	#animPlayer.play("blur_in")
	#yield(animPlayer, "animation_finished")
	# cambio de escena
	change_scene(scene)
	# blur out
	tween.interpolate_property(transition.we, "environment:dof_blur_near_amount", 1, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#tween.interpolate_property(transition.cr, "color", Color(0,0,0,1), Color(0,0,0,0), 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	#animPlayer.play_backwards("blur_out")
	#yield(animPlayer, "animation_finished")
	transition.layer = -1
	

	
	
	
	
	
