extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var dentro = false
var readyRight = false

var playerRight
var current

func _ready():
	sprite.rotation_degrees = 90

func _process(delta):
	animationPlayer.play("Move")

func _physics_process(delta):
	current = get_parent().current
	
	if current == 1:
		if (Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left")):
			if readyRight:
				playerRight.visible=true
				playerRight.set_physics_process(true)
				readyRight=false
			else:
				if dentro:
					playerRight = get_parent().get_child(1)
					playerRight.visible=false
					playerRight.set_physics_process(false)
					readyRight=true

func _on_DoorRight_body_entered(body):
	if body.name=="PlayerRight":
		dentro=true

func _on_DoorRight_body_exited(body):
	dentro=false
