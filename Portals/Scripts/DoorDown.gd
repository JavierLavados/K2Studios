extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var dentro = false
var readyDown = false

var playerDown
var current

func _ready():
	sprite.rotation_degrees = 180

func _process(delta):
	animationPlayer.play("Move")

func _physics_process(delta):
	current = get_parent().current
	
	if current == 2:
		if (Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up")):
			if readyDown:
				playerDown.visible = true
				playerDown.set_physics_process(true)
				readyDown = false
			else:
				if dentro:
					playerDown = get_parent().get_child(2)
					playerDown.visible = false
					playerDown.set_physics_process(false)
					readyDown = true

func _on_DoorDown_body_entered(body):
	if body.name=="PlayerDown":
		dentro=true

func _on_DoorDown_body_exited(body):
	dentro=false
