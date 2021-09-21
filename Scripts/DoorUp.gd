extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var dentro = false
var readyUp = false

var playerUp
var current

func _ready():
	sprite.rotation_degrees = 0

func _process(delta):
	animationPlayer.play("Move")

func _physics_process(delta):
	current = get_parent().current
	
	if current == 0:
		if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down")):
			if readyUp:
				playerUp.visible = true
				playerUp.set_physics_process(true)
				readyUp = false
			else:
				if dentro:
					playerUp = get_parent().get_child(0)
					playerUp.visible=false
					playerUp.set_physics_process(false)
					readyUp = true
	
func _on_DoorUp_body_entered(body):
	if body.name == "PlayerUp":
		dentro = true

func _on_DoorUp_body_exited(body):
	dentro = false
