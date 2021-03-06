extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var detector = $Detector
onready var climbArea = $ClimbArea/CollisionShape2D

var id = 1
var player_name = "PlayerRight"

var on_detector = false
var on_stairs = false
var increase = 0

func _ready():
	sprite.frame =  (8*(Globals.current_world-1)) + (id*2)

func _process(delta):
	
	if on_detector:
		if on_detector.climbing == -1:
			add_collision_exception_with(on_detector)
			on_detector.on_ladder += 1
			on_detector.climbing = 1
			increase += 1
			on_stairs = true
		else:
			if on_stairs:
				on_detector.on_ladder -= increase
				increase = 0
				on_stairs = false


func _on_ClimbArea_body_entered(body):
	if body.name == player_name:
		body.on_ladder += 1
		if body.climbing:
			add_collision_exception_with(body)

func _on_ClimbArea_body_exited(body):
	if body.name == player_name:
		body.on_ladder -= 1
		remove_collision_exception_with(body)

func _on_Detector_body_entered(body):
	if body.name == player_name:
		body.detector_pos = [Vector2(global_position.x+32,global_position.y),-1,false]
		on_detector = body

func _on_Detector_body_exited(body):
	if body.name == player_name:
		body.detector_pos = null
		on_detector = false
