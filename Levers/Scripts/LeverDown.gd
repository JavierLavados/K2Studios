extends "res://Levers/Scripts/LeverAbstract.gd"

func _on_LeverDown_body_entered(body):
	if body.name == "PlayerDown":
			inside = true

func _on_LeverDown_body_exited(body):
	inside = false
	
func _physics_process(delta):
	lever("up","down",2)
