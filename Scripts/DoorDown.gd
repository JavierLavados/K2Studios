extends Area2D

var dentro = false
var readyDown = false

var playerDown
var current

func _physics_process(delta):
	current = get_parent().current

	if Input.is_action_pressed("down") and dentro==true and readyDown==false and current==2:
		playerDown = get_parent().get_child(2)
		playerDown.visible=false
		playerDown.set_physics_process(false)
		readyDown=true
		
	if Input.is_action_pressed("up") and readyDown==true and current==2:
		playerDown.visible=true
		playerDown.set_physics_process(true)
		readyDown=false

	


func _on_DoorDown_body_entered(body):
	if body.name=="PlayerDown":
		dentro=true


func _on_DoorDown_body_exited(body):
	dentro=false
