extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var dentro = false
var readyLeft = false

var playerLeft
var current

func _ready():
	sprite.rotation_degrees = 270

func _process(delta):
	animationPlayer.play("Move")
	
func _physics_process(delta):
	current = get_parent().current
	
	if current == 3:
		if (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")):
			if readyLeft:
				playerLeft.visible = true
				playerLeft.set_physics_process(true)
				readyLeft = false
			else:
				if dentro:
					playerLeft = get_parent().get_child(3)
					playerLeft.visible = false
					playerLeft.set_physics_process(false)
					readyLeft = true
	
func _on_DoorLeft_body_entered(body):
	if body.name == "PlayerLeft":
		dentro = true

func _on_DoorLeft_body_exited(body):
	dentro = false
