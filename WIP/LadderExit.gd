extends StaticBody2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var detector = $Detector
onready var climbArea = $ClimbArea/CollisionShape2D

var id = 0

var on_detector = false
var on_stairs = false
var increase = 0

func _process(delta):
	
	if increase != 0:
		print(increase)
	
	if on_detector:
		if on_detector.climbing == -1:
			coll.set_deferred("disabled",true)
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
	if body.name == "PlayerUp":
		body.on_ladder += 1
		coll.set_deferred("disabled",true)

func _on_ClimbArea_body_exited(body):
	if body.name == "PlayerUp":
		body.on_ladder -= 1
		coll.set_deferred("disabled",false)

func _on_Detector_body_entered(body):
	if body.name == "PlayerUp":
		body.detector_pos = [int(global_position.x),-1]
		on_detector = body

func _on_Detector_body_exited(body):
	if body.name == "PlayerUp":
		body.detector_pos = null
		on_detector = false
