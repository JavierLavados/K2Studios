extends Area2D

var dentro = false
var readyLeft = false

var playerLeft
var current

func _physics_process(delta):
	current = get_parent().current

	if Input.is_action_pressed("left") and dentro==true and readyLeft==false and current==3:
		playerLeft = get_parent().get_child(3)
		playerLeft.visible=false
		playerLeft.set_physics_process(false)
		readyLeft=true
		
	if Input.is_action_pressed("right") and readyLeft==true and current==3:
		playerLeft.visible=true
		playerLeft.set_physics_process(true)
		readyLeft=false

	


func _on_DoorLeft_body_entered(body):
	if body.name=="PlayerLeft":
		dentro=true


func _on_DoorLeft_body_exited(body):
	dentro=false
