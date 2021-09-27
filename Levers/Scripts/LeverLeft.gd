extends "res://Levers/Scripts/LeverAbstract.gd"

func _on_LeverLeft_body_entered(body):
	if body.name == "PlayerLeft":
			inside = true

func _on_LeverLeft_body_exited(body):
	inside = false
	

func _physics_process(delta):
	lever("left","right",3,51,50)

