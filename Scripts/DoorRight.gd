extends Area2D

var dentro = false
var readyRight = false

var playerRight
var current

func _physics_process(delta):
	current = get_parent().current

	if Input.is_action_pressed("right") and dentro==true and readyRight==false and current==1:
		playerRight = get_parent().get_child(1)
		playerRight.visible=false
		playerRight.set_physics_process(false)
		readyRight=true
		
	if Input.is_action_pressed("left") and readyRight==true and current==1:
		playerRight.visible=true
		playerRight.set_physics_process(true)
		readyRight=false

	


func _on_DoorRight_body_entered(body):
	if body.name=="PlayerRight":
		dentro=true


func _on_DoorRight_body_exited(body):
	dentro=false
