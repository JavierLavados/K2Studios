extends "res://Levers/Scripts/LeverAbstract.gd"

func _on_LeverUp_body_entered(body):
	if body.name == "PlayerUp":
			inside = true

func _on_LeverUp_body_exited(body):
	inside = false

func _physics_process(delta):
	lever("up","down",0,41,40)
