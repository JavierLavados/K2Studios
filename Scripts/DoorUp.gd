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

	if Input.is_action_pressed("up") and dentro==true and readyUp==false and current==0:
		playerUp = get_parent().get_child(0)
		playerUp.visible=false
		playerUp.set_physics_process(false)
		readyUp=true
		
	if Input.is_action_pressed("down") and readyUp==true and current==0:
		playerUp.visible=true
		playerUp.set_physics_process(true)
		readyUp=false

	


func _on_DoorUp_body_entered(body):
	if body.name=="PlayerUp":
		dentro=true


func _on_DoorUp_body_exited(body):
	dentro=false
