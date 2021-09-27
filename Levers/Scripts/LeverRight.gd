extends "res://Levers/Scripts/LeverAbstract.gd"

func _on_LeverRight_body_entered(body):
	if body.name == "PlayerRight":
			inside = true
			
func _on_LeverRight_body_exited(body):
	inside = false

func _physics_process(delta):
	lever("left","right",1,43,42)
